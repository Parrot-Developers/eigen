
/**
 *  Returns the roll associated to the quaternion, in degrees
 */
inline Scalar roll() const { return atan2f(2.0*(this->w() * this->x() + this->y() * this->z()), 1 - 2*(this->x() * this->x() + this->y() * this->y())) * 180/M_PI; }

/**
 *  Returns the roll associated to the quaternion, in rads
 */
inline Scalar rollRad() const { return atan2f(2.0*(this->w() * this->x() + this->y() * this->z()), 1 - 2*(this->x() * this->x() + this->y() * this->y())); }


/**
 *  Returns the pitch associated to the quaternion, in degrees
 */
inline Scalar pitch() const { return -asinf(2.0*(this->x() * this->z() - this->w() * this->y())) * 180/M_PI; }

/**
 *  Returns the pitch associated to the quaternion, in rads
 */
inline Scalar pitchRad() const { return -asinf(2.0*(this->x() * this->z() - this->w() * this->y())); }


/**
 *  Returns the yaw associated to the quaternion, in degrees
 */
inline Scalar yaw() const { return atan2f(2.0*(this->w() * this->z() + this->x() * this->y()), 1 - 2*(this->y() * this->y() + this->z() * this->z())) * 180/M_PI; }

/**
 *  Returns the yaw associated to the quaternion, in rads
 */
inline Scalar yawRad() const { return atan2f(2.0*(this->w() * this->z() + this->x() * this->y()), 1 - 2*(this->y() * this->y() + this->z() * this->z())); }


/**
 *  Returns the angles associated to the quaternion, in degrees, in the order: roll - pitch - yaw
 */
inline Vector3 angles() const { return Vector3(this->roll(), this->pitch(), this->yaw()); }

/**
 *  Returns the angles associated to the quaternion, in rads, in the order: roll - pitch - yaw
 */
inline Vector3 anglesRad() const { return Vector3(this->rollRad(), this->pitchRad(), this->yawRad()); }
