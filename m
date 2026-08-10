Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D53DB655
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367202; cv=none; b=rH0NmRme4umGR7VHc6f/Rrufk75J7/ZAQDIX88ad58DEBUpN0O/ll9LpfvoQFraWpDy/py6luypAYI75wRDuRxSE2GPoU2ArWeEaS+O+LQNpYhAk/nt2sr+2CWMey5S5RhGHFvH6RvMzRoM6wMPoXrazdNhvQUbt8HMbMZtxgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367202; c=relaxed/simple;
	bh=lny2tVxPP3EBC64DjZVVlmMheEKgPPMBmx7Is6mdwkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=chPjvEIF9epa5bVZG90M6jBslqSRxwckuBia2bBS+VjHMAgHnrjzk0I+GWmWCHd+M3ZXixLsKmnhe4PLh/TDfWzpEosSgILew1lkTOJDPMVuWJM0skba3If7oZcoXcPBoyvHCnfo7uvCSuld8+4xeqbRX8z1as5bBhSqR7/mT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mkmkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVDUbSSL; arc=none smtp.client-ip=209.85.208.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mkmkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVDUbSSL"
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39d93d95a21so12887561fa.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786367198; x=1786971998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Aj+m8iVcwc+I5UrIpsW4B7C15egkkpzlbpamrytbNZ4=;
        b=PVDUbSSLiHaOizW11PbDYBZKQ7gInP5wR8ESqBZEZ5q+RG+nBz3l5w0rNvLsJr40rn
         X/ouFLi4+rQo73nuZIoKyo8gw3OVsOscsiGe0LdRA2W2AzX+3S81ZLwlWnxTkopZ3U08
         LtmhNQtmg+nWwHYpMTKG2w79Ig2KkAbzqfeF0l4XMem/15J0Q+9fY7IWuhc+r9tFg2vs
         OAPaADBDFTJwseJfjkpyzTLxbFb0nVrMdLLKOIW8m173btSWOirwdJb0x+jK2QZQsl2Q
         UNE6Q3pd5e5FF6iZDQIusOSKJ6dvhs6IiQGHeUjJnFmV7rWf2KOzZ9BuFFk8KeH+FiRu
         LIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367198; x=1786971998;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aj+m8iVcwc+I5UrIpsW4B7C15egkkpzlbpamrytbNZ4=;
        b=A0WOqlvzvRlp+WO4BGw9Bd7Js65EnZ2JEShMqxPoKFW04WNPU31LJem96RdoZUzshK
         I4Im80umkkR0sN/hQMOvzo6mhPsj+8JTPBZR19OnBruQR0JkO+UebWxc955zaBXlMOqH
         lxygxJB193pwy2wmLKEWic63RuNq4hChOmzGkAtDPTG0uBIhLFzSzx9GO/ydmn2SQY79
         OspyZqfKBom1otfZV0z+egB1MQjhKrMUwT1sruNs+4Xch4PchMmkC5f9vxUGYLDMwN8G
         s7XKBl0D/+B54X93k5kU0cTc3ZzZo+JSeozsx02Fc/ngL7C633X6OrXhIFAelu1cBnre
         kD9A==
X-Forwarded-Encrypted: i=1; AHgh+Rp8kWlsGq76+A+9TlVWIWsc3ATW5S5nXXa2Nr5nkRlS9DC89GDjVd1W+gzXsD6yIwgS32OMhELEW8sHWVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IQWOVKVHgHOKealRvhT4uKaHMILMioOa42wp7a5SJ0Jg6cEw
	UWKti2O1WWv8sZLPZBrsv6DU6rLlW0IMPUUffbmQk5ALJkCS84ZFWzYkeIiS1No/k/+P5LlVjzQ
	m7g==
X-Received: from ljic26-n2.prod.google.com ([2002:a05:651c:235a:20b0:39e:e62c:8bfc])
 (user=mkmkl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:198c:b0:39c:6f75:2eea
 with SMTP id 38308e7fff4ca-39fdf42ae01mr28082051fa.11.1786367197480; Mon, 10
 Aug 2026 06:06:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:06:34 +0000
In-Reply-To: <20260810130635.1166626-1-mkmkl@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810130635.1166626-2-mkmkl@google.com>
Subject: [PATCH v1 1/2] pinctrl: core: Allow drivers to keep "init" pinctrl
 state after probe
From: "=?UTF-8?q?Micha=C5=82=20Karda=C5=9B?=" <mkmkl@google.com>
To: Linus Walleij <linusw@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Douglas Anderson <dianders@chromium.org>, Vic Huang <vich@google.com>, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Micha=C5=82=20Karda=C5=9B?=" <mkmkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

During device probe, pinctrl_bind_pins() binds pins to their "init" state
if specified in Device Tree. When probe finishes, pinctrl_init_done()
automatically transitions the pins from "init" to "default" state.

While this auto-transition works well for devices that are immediately
active upon driver binding, certain peripherals (such as power-sequenced
devices connected over UART, SPI, or other buses) remain unpowered until
userspace explicitly opens the device node or attaches a protocol driver.

On board designs where the connected peripheral is kept unpowered during
boot, auto-selecting "default" or "sleep" pin states (where signals such
as TXD or RTS may be driven high or pulled up) can cause parasitic
back-powering into the unpowered peripheral through its ESD protection
diodes.

Allow drivers to explicitly opt out of the automatic "init" -> "default"
transition by calling pinctrl_keep_init_state(dev) during probe. When this
helper is called, pinctrl_init_done() leaves the pins in their "init"
state upon probe completion. The driver can then transition to the
"default" state when the device is first opened by calling
pinctrl_pm_select_default_state(dev).

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Micha=C5=82 Karda=C5=9B <mkmkl@google.com>
---
 Documentation/driver-api/pin-control.rst | 10 ++++++----
 drivers/pinctrl/core.c                   | 20 ++++++++++++++++++++
 include/linux/pinctrl/consumer.h         |  6 ++++++
 include/linux/pinctrl/devinfo.h          |  2 ++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/drive=
r-api/pin-control.rst
index 1f585ecca63c..8d52bf74da6c 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -1172,7 +1172,8 @@ Possible standard state names are: "default", "init",=
 "sleep" and "idle".
=20
 - if ``init`` and ``default`` are defined in the device tree, the "init"
   state is selected before the driver probe and the "default" state is
-  selected after the driver probe.
+  selected after the driver probe, unless the driver explicitly opts out
+  by calling ``pinctrl_keep_init_state()`` during probe.
=20
 - the ``sleep`` and ``idle`` states are for power management and can only
   be selected with the PM API bellow.
@@ -1233,9 +1234,10 @@ operation and going to sleep, moving from the ``PINC=
TRL_STATE_DEFAULT`` to
 current in sleep mode.
=20
 Another case is when the pinctrl needs to switch to a certain mode during
-probe and then revert to the default state at the end of probe. For exampl=
e
-a PINMUX may need to be configured as a GPIO during probe. In this case, u=
se
-``PINCTRL_STATE_INIT`` to switch state before probe, then move to
+probe and then revert to the default state at the end of probe (or remain
+in the init state until activated if ``pinctrl_keep_init_state()`` is call=
ed).
+For example a PINMUX may need to be configured as a GPIO during probe. In =
this
+case, use ``PINCTRL_STATE_INIT`` to switch state before probe, then move t=
o
 ``PINCTRL_STATE_DEFAULT`` at the end of probe for normal operation.
=20
 A driver may request a certain control state to be activated, usually just=
 the
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 1675dd36bd5c..fd0c91610338 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1640,6 +1640,9 @@ int pinctrl_init_done(struct device *dev)
 	if (pins->p->state !=3D pins->init_state)
 		return 0; /* Not at init anyway */
=20
+	if (pins->keep_init)
+		return 0; /* Driver explicitly requested to stay in init state */
+
 	if (IS_ERR(pins->default_state))
 		return 0; /* No default state */
=20
@@ -1678,6 +1681,23 @@ int pinctrl_select_default_state(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pinctrl_select_default_state);
=20
+/**
+ * pinctrl_keep_init_state() - mark pinctrl handle to stay in init state a=
fter probe
+ * @dev: device to keep init state for
+ *
+ * Return: true if the device has a valid init state and keep_init flag wa=
s set,
+ *         false otherwise.
+ */
+bool pinctrl_keep_init_state(struct device *dev)
+{
+	if (!dev->pins || IS_ERR(dev->pins->init_state))
+		return false;
+
+	dev->pins->keep_init =3D true;
+	return true;
+}
+EXPORT_SYMBOL_GPL(pinctrl_keep_init_state);
+
 #ifdef CONFIG_PM
=20
 /**
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consu=
mer.h
index 11b8f0b8da0c..4312a098fb4c 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -47,6 +47,7 @@ int pinctrl_select_state(struct pinctrl *p, struct pinctr=
l_state *s);
 struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
 void devm_pinctrl_put(struct pinctrl *p);
 int pinctrl_select_default_state(struct device *dev);
+bool pinctrl_keep_init_state(struct device *dev);
=20
 #ifdef CONFIG_PM
 int pinctrl_pm_select_default_state(struct device *dev);
@@ -152,6 +153,11 @@ static inline int pinctrl_select_default_state(struct =
device *dev)
 	return 0;
 }
=20
+static inline bool pinctrl_keep_init_state(struct device *dev)
+{
+	return false;
+}
+
 static inline int pinctrl_pm_select_default_state(struct device *dev)
 {
 	return 0;
diff --git a/include/linux/pinctrl/devinfo.h b/include/linux/pinctrl/devinf=
o.h
index de4228eea90a..13dac33f2df1 100644
--- a/include/linux/pinctrl/devinfo.h
+++ b/include/linux/pinctrl/devinfo.h
@@ -32,6 +32,7 @@ struct pinctrl;
  * @init_state: the state at probe time, if found
  * @sleep_state: the state at suspend time, if found
  * @idle_state: the state at idle (runtime suspend) time, if found
+ * @keep_init: flag indicating if init state should persist after probe
  */
 struct dev_pin_info {
 	struct pinctrl *p;
@@ -41,6 +42,7 @@ struct dev_pin_info {
 	struct pinctrl_state *sleep_state;
 	struct pinctrl_state *idle_state;
 #endif
+	bool keep_init:1;
 };
=20
 extern int pinctrl_init_done(struct device *dev);
--=20
2.55.0.654.g21b8a5bc05-goog

