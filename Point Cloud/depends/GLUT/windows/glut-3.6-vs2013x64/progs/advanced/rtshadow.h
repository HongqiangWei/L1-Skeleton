#ifndef __rtshadow_h__
#define __rtshadow_h__

/* Copyright (c) Mark J. Kilgard, 1997. */

/* This program is freely distributable without licensing fees and is
   provided without guarantee or warrantee expressed or implied.  This
   program is -not- in the public domain. */

/* Real-time Shadowing library, Version 0.8 */

#ifdef WIN32
#include <windows.h>
#endif
#include <GL/gl.h>
#include <GL/glu.h>

#ifdef __cplusplus
extern "C" {
#endif

enum {
  RTS_ERROR_OUT_OF_MEMORY,
  RTS_WARNING_EYE_IN_SHADOW,
  RTS_WARNING_LIGHT_TOO_CLOSE
};

typedef enum {
  RTS_OFF,
  RTS_SHINING,
  RTS_SHINING_AND_CASTING
} RTSlightState;

typedef enum {
  RTS_NOT_SHADOWING,
  RTS_SHADOWING
} RTSobjectState;

typedef enum {
  RTS_NO_SHADOWS,
  RTS_USE_SHADOWS,
  RTS_USE_SHADOWS_NO_OVERLAP
} RTSmode;

typedef struct RTSscene RTSscene;
typedef struct RTSlight RTSlight;
typedef struct RTSobject RTSobject;

typedef void (*RTSerrorHandler) (int error, char *message);

extern RTSscene *rtsCreateScene(
  GLfloat eyePos[3],
  GLbitfield usableStencilBits,
  void (*renderSceneFunc) (GLenum castingLight, void *sceneData, RTSscene * scene),
  void *sceneData);
extern RTSlight *rtsCreateLight(
  GLenum glLight,
  GLfloat lightPos[3],
  GLfloat radius);
extern RTSobject *rtsCreateObject(
  GLfloat objectPos[3],
  GLfloat maxRadius,
  void (*renderObject) (void *objectData),
  void *objectData,
  int feedbackBufferSizeGuess);

extern void rtsAddLightToScene(
  RTSscene * scene,
  RTSlight * light);
extern void rtsAddObjectToLight(
  RTSlight * light,
  RTSobject * object);

extern void rtsRemoveLightFromScene(
  RTSscene * scene,
  RTSlight * light);
extern void rtsRemoveObjectFromLight(
  RTSlight * light,
  RTSobject * object);

extern void rtsSetLightState(
  RTSlight * light,
  RTSlightState state);
extern void rtsSetObjectState(
  RTSobject * object,
  RTSobjectState state);

extern void rtsUpdateEyePos(
  RTSscene * scene,
  GLfloat eyePos[3]);
extern void rtsUpdateUsableStencilBits(
  RTSscene * scene,
  GLbitfield usableStencilBits);

extern void rtsUpdateLightPos(
  RTSlight * light,
  GLfloat lightPos[3]);
extern void rtsUpdateLightRadius(
  RTSlight * light,
  GLfloat lightRadius);

extern void rtsUpdateObjectPos(
  RTSobject * object,
  GLfloat objectPos[3]);
extern void rtsUpdateObjectShape(
  RTSobject * object);
extern void rtsUpdateObjectMaxRadius(
  RTSobject * object,
  GLfloat maxRadius);

extern void rtsFreeScene(
  RTSscene * scene);
extern void rtsFreeLight(
  RTSlight * light);
extern void rtsFreeObject(
  RTSobject * object);

extern int rtsTriviallyOutsideShadowVolume(
  RTSscene * scene,
  GLfloat objectPos[3],
  GLfloat maxRadius);

extern void rtsRenderScene(
  RTSscene * scene,
  RTSmode mode);

extern void rtsRenderSilhouette(
  RTSscene * scene,
  RTSlight * light,
  RTSobject * object);

extern RTSerrorHandler rtsSetErrorHandler(
  RTSerrorHandler handler);

#ifdef __cplusplus
}

#endif
#endif /* __rtshadow_h__ */
