Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399843;
	b=AtaOpqrEf1YNR6kWPP5F1Yg+ahahoZI8A2Ll/+7hnK8XsTQehNdVR1k5Qfn5EIexpMnS
	 2CpJbPXETXcEkJN9WxHonqUSmADKSMxWIXoV8h9vxl2/9lSvSkhRFa65Z5OJ9+zbNc7pL
	 UsRWYMUS2tINQSLIMou51m1i99SOS1+euQ9n/xv864c+XDbR3ghcELyioMtF/OsW6/mKY
	 BSgEFT0fG9CrqUL/lnQsm8od7T6Z7yAR99pluX7ejE6RvrVCzUTFpD73RanPkA9P+ZNYk
	 cxlNIPhaH1u52DGA25WBWkjWGHUVA9/rJWpP2hRZqoERu8EEuLbyaM3MXV2G9pbpBWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iy2vWnAv47fFBVaJTkHBzmpFs80GGZb6KnvE0IocUHo=;
	b=OXW+q118kva+E/1uzy7/UgjMHOmfv9DdKWik9sA2goM2m0TPnAtmCfxyxX+MIcIUWU+Y
	 1CXr0HiTv2bkb3K92APuDcfvQWaJumx9PaBA9jzq8Vqn8TpDrDQRZuWPx2oFUZo0nc5Up
	 dYrpzyGvk0Hr7ztriCq7C7oqENNv85pnknaYZqxZW/urer04w0GWK7ne45iLebZm1Ek5e
	 avxIJ2iZVt4AE1jdkPoQVFHqGufPF6v946zb4SfkdMY8Z/1tFSZ4HZkFM/PzoX9IpRfjR
	 fnA4wslVEz+VB4heK7bo57o0e6UpS0lMjDQ1CBZTV03gO3X9r+HlRJe5JfhzA2Rs2Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=liDP2yMk;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F4606A31C
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C0F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=liDP2yMk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so664106f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399841; x=1794004641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iy2vWnAv47fFBVaJTkHBzmpFs80GGZb6KnvE0IocUHo=;
        b=liDP2yMkAQsavocyDzM8xkVy8FVhK/1vLsOoln2jfsx66BKSp/9TY4gurQ/Piuq3FM
         grR5p7cpB/cPdLjeoJzFH3adEg01Iu5lOImrTIYTiGOJ1eBlVZ8kwW61QZ8EdamNIL4z
         IJfjV+BuWfoKUWXm44zxmi17oKU8AnxMuNclGjomM5yeFzm6n4dr/WKn3bUEUid4SLQj
         tp0MVn5eyQERzWvEVnf9JAjWJ7YgL7a5ckdURnvOk/Z4pJhLIzkH5dXoZ2FEQOI43FkT
         likNs1IiIZooAPlglJzC4/Y6r6lw/ReOGdfUra7UET4eWUUgCI1EchqdPBqRUqI4KBcW
         WgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399841; x=1794004641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iy2vWnAv47fFBVaJTkHBzmpFs80GGZb6KnvE0IocUHo=;
        b=FQR3QWinr180B9y6spcYS9Y256nk+t2H1r0fOfDsi26vlaUYn87xREo/rd/Xrq953o
         oy8ZyL9maijZzJvwgf401q6qhGdayGB4/eCfN6D7emHF/b5M2htQpqaefIOLF2nEDcjT
         MEgjbOnqSHbX7OtHP5lH3Fnz0BMr2a1/+qvbvVHIMxmihr23fd8uwPLCMRAGVzu1BaoN
         IqrL5lqi1FDIaAaL6oHrEoJcdx6nio/kKg/sphwxIMAMpByWgxpfT3/V5p851qoHPQ7i
         IkDbj0gR4Jpwwo6R3BiFvraLptscpDq+HImn3KLoyJ4Z4hJQHl2FBXZaO0hvZauQRmq0
         Cm5Q==
X-Forwarded-Encrypted: i=1; AKwUvByt0jaPWbHjz7ywOCObiQ9UkZMnEPVFaiHBeoh7v6POEGLYPkVzOmepj8Lyw5GBYM6PuJ5oRVsrIrgUOE8=@vger.kernel.org
X-Gm-Message-State: AFq9FYITy213Zlwx5AcQKoiuukuCjIeaokVWs3ruxvOLiaiCq4piWjsG
	wpRo7fyMeh6OFwpi4RLAAR5rpHGL2GioeWd5gJNeNwCPadT23SEKfboz
X-Gm-Gg: AYBFou3KPJzJKBx9VCI0nw9ue7fHxQLG3VCA6Kv/sjh4TkKjOHhrTCdRvz2Y97/PkTB
	g9JEnM1gWAr9N+76+yPOLntzsy56on/E5YbmHE6DHfr2gxd/cSZk+0yyHqghmzTZqb/8VYcxeAv
	UyZg0eWzbw1JG9VorLdtTNts6X/qwnFIorwyBdxkOzIIUZ6EHiLnH4yaxJBnHR4Mvl5i15iYa75
	PyuQPBHl2RAN1sOUUr191Fh7SD0U5R9/cYjv8w86lcx8XBvY3evhWXpLr/ROyyGH3X9znobzeqI
	rxjfTt1bMKipZHYJ3JIw1+Slvt0t8goZBBcK4V9NCgYxDFQFs6ypuqm/dEml25AJxdeknq9Uw9l
	HT9PvaXvBV7vE/mJOzo2p5gRd6kP8DgK+t3MoTNV51WA7qwPLX1mSKqnEjLBP58HzS8vyh6s+RT
	R1nFvmSeW3i8T8/70oZI8Sx1+h3t3PdwJAKRjHaXxj1tKuFP0qy8jVoFM6LEYTM3T55ENz+wJv2
	v3Hz8OQq5DTQStU6s7RwWjIuhYDttC6g1Sl59XHo2YgFh3THSz0Oe1tNjAH3Y4qDU1Nru4cPwBj
	0oiH4zH7s29pO5bUb57Lz6EnzQ6qkA==
X-Received: by 2002:a05:6000:2c0f:b0:48d:faf4:54a8 with SMTP id ffacd0b85a97d-48e6e2eb434mr8052401f8f.11.1793399840783;
        Fri, 30 Oct 2026 15:37:20 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:20 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Andreas Boose <Andreas.Boose@almex.de>
Subject: [PATCH v2 11/15] HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration
Date: Sat, 31 Oct 2026 00:36:33 +0200
Message-ID: <20261030223637.86907-12-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FTDI errata TN_189 (Section 2.1) documents a silicon bug where the
FT260's USB interrupt endpoints are occasionally halted right after
enumeration. When this happens, Clear-Feature ENDPOINT_HALT does not
recover the endpoint and the only known recovery is a USB device reset.

This patch implements an in-driver workaround:

  1. ft260_check_intr_ep_health() observes the STALL by attempting an
     actual interrupt IN transfer. The FT260 does not honestly report
     its halt state via USB_REQ_GET_STATUS (returns 0 even when
     STALLed; confirmed separately by FTDI engineering with a USB
     analyzer trace), so we cannot rely on it; instead we let the
     host controller return -EPIPE when it sees the STALL handshake.

  2. ft260_check_dev_responsive() catches the broader broken state
     where the interrupt endpoint may look healthy but the device
     still fails to respond to control transfers. A USB_REQ_GET_STATUS
     to the device with a short 500 ms timeout fails fast on a broken
     device, preventing later probe stages from hanging on usbhid's
     default 10 s timeouts and starving the usb_hub_wq workqueue.

  3. When either check fails, probe schedules a deferred work item
     and returns -ENODEV so that hub_event releases the device lock
     quickly. The work item retries usb_lock_device_for_reset() up to
     10 times (~10 s; each attempt already polls for up to one second)
     before giving up, then calls usb_reset_device() and explicitly
     unbinds/rebinds all USB interfaces to force usbhid to recreate
     the HID devices and trigger a fresh ft260_probe(). The
     unbind+rebind step is needed because usbhid's pre_reset and
     post_reset both return 0, so usb_reset_device() alone keeps
     usbhid bound to stale HID device state.

FTDI engineering tested this on a Raspberry Pi 4 Model B Rev 1.5
running Linux 6.12.62-v8+ on an xhci_hcd host, with the FT260 connected
at full-speed through a downstream USB 2.0 hub. Across 28,684
re-enumeration cycles, 350 cycles triggered the recovery path. Two of
those required two consecutive USB resets before the device returned.
All 28,684 cycles recovered to a fully functional state with I2C and
UART working end-to-end.

Queue the work on a driver-owned ordered workqueue flushed on module
exit. Do not treat a GFP failure as a TN_189 stall (reported by
Sashiko). Leave the reset requeue uncapped: that is the recovery FTDI
tested.

Reported-by: Andreas Boose <Andreas.Boose@almex.de>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/40
Link: https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-Technical-Note.pdf
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: flush reset work on unload; do not reset on -ENOMEM (reported by
Sashiko). Reset requeue left uncapped (FTDI recovery path).
---
 drivers/hid/hid-ft260.c | 245 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 65835e13fa2a..923ce6ee9dcf 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -12,6 +12,7 @@
 #include <linux/hidraw.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/workqueue.h>
 #include <linux/usb.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
@@ -2396,15 +2397,229 @@ static int ft260_uart_probe(struct ft260_device *dev,
 	return ret;
 }
 
+/*
+ * FT260 errata TN_189 Section 2.1: the USB interrupt endpoints are
+ * occasionally halted right after enumeration. When this happens:
+ *  - Standard Clear-Feature ENDPOINT_HALT does not recover the endpoint
+ *  - Subsequent communication with the device is dead
+ *  - The only known recovery is a USB device reset
+ *
+ * A separate finding from FTDI engineering (confirmed by USB analyzer
+ * trace while testing this workaround) is that the FT260 does NOT
+ * honestly report the halt state via USB_REQ_GET_STATUS: it returns 0
+ * even when the endpoint is STALLed. Detection must therefore observe
+ * the STALL handshake at the host controller level rather than ask
+ * the device.
+ *
+ * Recovery is performed by a deferred work item that resets the USB
+ * device and unbinds/rebinds all interfaces to force usbhid to
+ * destroy stale HID devices and create fresh ones, which triggers a
+ * new ft260_probe() that succeeds.
+ *
+ * https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-Technical-Note.pdf
+ */
+struct ft260_reset_work {
+	struct work_struct work;
+	struct usb_interface *usbif;
+};
+
+static struct workqueue_struct *ft260_reset_wq;
+
+static void ft260_reset_and_rebind(struct work_struct *ws)
+{
+	struct ft260_reset_work *rw =
+		container_of(ws, struct ft260_reset_work, work);
+	struct usb_interface *usbif = rw->usbif;
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	struct usb_host_config *actconfig;
+	int ret, i, attempt;
+
+	/*
+	 * Retry the device lock for up to ~10 seconds. The lock is held
+	 * by hub_event for the duration of device enumeration; with the
+	 * fast-fail responsiveness check in probe, both interfaces should
+	 * abort within ~1-2 seconds, after which the lock becomes free.
+	 * Each usb_lock_device_for_reset() attempt already polls for up to
+	 * one second internally.
+	 */
+	for (attempt = 0; attempt < 10; attempt++) {
+		ret = usb_lock_device_for_reset(usbdev, NULL);
+		if (ret >= 0)
+			break;
+		if (ret == -ENODEV || ret == -EHOSTUNREACH) {
+			dev_dbg(&usbif->dev,
+				"device gone before reset (%d), abort\n", ret);
+			goto out;
+		}
+		/* -EBUSY: someone else holds the lock; retry. */
+	}
+	if (ret < 0) {
+		dev_err(&usbif->dev,
+			"failed to acquire USB device lock for reset after %d attempts: %d\n",
+			attempt, ret);
+		goto out;
+	}
+
+	ret = usb_reset_device(usbdev);
+	if (ret < 0) {
+		dev_err(&usbif->dev, "USB reset failed: %d\n", ret);
+		usb_unlock_device(usbdev);
+		goto out;
+	}
+
+	/*
+	 * usb_reset_device() keeps usbhid bound (its pre_reset/post_reset
+	 * both return 0) and does not re-trigger HID-level driver probing.
+	 * Unbind and rebind all USB interfaces to force usbhid to destroy
+	 * stale HID devices and create new ones, which triggers fresh
+	 * ft260_probe() calls.
+	 */
+	actconfig = usbdev->actconfig;
+	for (i = 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = actconfig->interface[i];
+
+		if (intf && intf->dev.driver)
+			device_release_driver(&intf->dev);
+	}
+	for (i = 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = actconfig->interface[i];
+
+		if (!intf)
+			continue;
+		ret = device_attach(&intf->dev);
+		if (ret < 0)
+			dev_err(&intf->dev,
+				"failed to rebind USB interface: %d\n", ret);
+	}
+
+	usb_unlock_device(usbdev);
+out:
+	usb_put_intf(usbif);
+	kfree(rw);
+}
+
+static int ft260_schedule_reset(struct usb_interface *usbif)
+{
+	struct ft260_reset_work *rw;
+
+	rw = kmalloc_obj(*rw, GFP_KERNEL);
+	if (!rw)
+		return -ENOMEM;
+
+	usb_get_intf(usbif);
+	rw->usbif = usbif;
+	INIT_WORK(&rw->work, ft260_reset_and_rebind);
+	queue_work(ft260_reset_wq, &rw->work);
+
+	return 0;
+}
+
+/*
+ * Detect whether the device's interrupt IN endpoint is in the STALL
+ * state described by TN_189. GET_STATUS is unreliable on the FT260
+ * (returns 0 even when halted, confirmed by FTDI with a USB analyzer
+ * trace), so observe the STALL handshake by attempting an actual
+ * interrupt IN transfer. The host controller returns -EPIPE when it
+ * receives a STALL handshake.
+ *
+ * Must be called before hid_hw_open() so it does not race against
+ * usbhid's own interrupt IN URB.
+ */
+static int ft260_check_intr_ep_health(struct hid_device *hdev)
+{
+	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	struct usb_host_interface *iface_desc = usbif->cur_altsetting;
+	struct usb_endpoint_descriptor *ep = NULL;
+	unsigned int pipe;
+	u8 *buf;
+	int ret, actual_length, i;
+
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		if (usb_endpoint_is_int_in(&iface_desc->endpoint[i].desc)) {
+			ep = &iface_desc->endpoint[i].desc;
+			break;
+		}
+	}
+	if (!ep)
+		return 0;
+
+	buf = kmalloc(FT260_REPORT_MAX_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvintpipe(usbdev, ep->bEndpointAddress);
+	ret = usb_interrupt_msg(usbdev, pipe, buf, FT260_REPORT_MAX_LEN,
+				&actual_length, 100);
+	kfree(buf);
+
+	if (ret == -EPIPE) {
+		hid_warn(hdev,
+			 "interrupt IN ep %#x halted (TN_189 errata), scheduling USB reset and rebind\n",
+			 ep->bEndpointAddress);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * Quick check that the device responds to a standard control transfer.
+ * When the FT260 is in the buggy post-enumeration state, control
+ * transfers initiated by later probe stages (chip version retrieval,
+ * UART/I2C configuration, etc.) can hang for very long periods,
+ * starving the usb_hub_wq workqueue and preventing the reset work
+ * from acquiring the device lock.
+ *
+ * Issue USB_REQ_GET_STATUS to the device (any compliant USB device
+ * must answer immediately) with a short explicit timeout. If it
+ * fails, treat the device as broken and bail out before reaching
+ * anything that can block.
+ *
+ * The interrupt-endpoint health check above only catches STALLs on
+ * the interrupt IN path; this check catches the broader broken state
+ * that affects the other interface even when its interrupt endpoint
+ * happens to look healthy.
+ */
+static int ft260_check_dev_responsive(struct hid_device *hdev)
+{
+	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	__le16 *status;
+	int ret;
+
+	status = kmalloc_obj(*status, GFP_KERNEL);
+	if (!status)
+		return -ENOMEM;
+
+	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
+			      USB_REQ_GET_STATUS,
+			      USB_DIR_IN | USB_RECIP_DEVICE,
+			      0, 0, status, sizeof(*status), 500);
+	kfree(status);
+
+	if (ret < 0) {
+		hid_warn(hdev,
+			 "device unresponsive to GET_STATUS (%d), suspected TN_189 errata, scheduling USB reset and rebind\n",
+			 ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ft260_device *dev;
+	struct usb_interface *usbif;
 	struct ft260_get_chip_version_report version;
 	struct ft260_get_system_status_report cfg;
 	int ret;
 
 	if (!hid_is_usb(hdev))
 		return -EINVAL;
+
+	usbif = to_usb_interface(hdev->dev.parent);
 	/*
 	 * We cannot use devm_kzalloc here because the port has to survive
 	 * until destroy function call.
@@ -2432,6 +2647,27 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto hid_fail;
 	}
 
+	/*
+	 * TN_189 errata workaround: bail out fast on a broken device so
+	 * that hub_event releases the device lock quickly, allowing the
+	 * scheduled reset work to acquire it and recover the device.
+	 */
+	ret = ft260_check_intr_ep_health(hdev);
+	if (ret == -ENODEV) {
+		ft260_schedule_reset(usbif);
+		goto err_hid_stop;
+	}
+	if (ret)
+		goto err_hid_stop;
+
+	ret = ft260_check_dev_responsive(hdev);
+	if (ret == -ENODEV) {
+		ft260_schedule_reset(usbif);
+		goto err_hid_stop;
+	}
+	if (ret)
+		goto err_hid_stop;
+
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "failed to open HID HW\n");
@@ -2621,6 +2857,12 @@ static int __init ft260_driver_init(void)
 		goto err_reg_driver;
 	}
 
+	ft260_reset_wq = alloc_ordered_workqueue("hid-ft260-reset", 0);
+	if (!ft260_reset_wq) {
+		ret = -ENOMEM;
+		goto err_reg_driver_unreg;
+	}
+
 	ret = hid_register_driver(&ft260_driver);
 	if (ret) {
 		pr_err("hid_register_driver failed: %d\n", ret);
@@ -2630,6 +2872,8 @@ static int __init ft260_driver_init(void)
 	return 0;
 
 err_reg_hid:
+	destroy_workqueue(ft260_reset_wq);
+err_reg_driver_unreg:
 	tty_unregister_driver(ft260_tty_driver);
 err_reg_driver:
 	tty_driver_kref_put(ft260_tty_driver);
@@ -2640,6 +2884,7 @@ static int __init ft260_driver_init(void)
 static void __exit ft260_driver_exit(void)
 {
 	hid_unregister_driver(&ft260_driver);
+	destroy_workqueue(ft260_reset_wq);
 	tty_unregister_driver(ft260_tty_driver);
 	tty_driver_kref_put(ft260_tty_driver);
 }
-- 
2.43.0

