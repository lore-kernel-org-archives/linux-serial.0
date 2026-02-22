Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D869A932
	for <linux-serial@vger.kernel.org>; Sun, 22 Feb 2026 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771802963; cv=none; b=XpZ9t0FiGNELTZeT3l9JqovSGR6ZZpbnZLei/h1GVZdJNspVjLMz9CxUWR1U0/mZofE3wOSrjDlgh03g7SpYR1qWoBzeV6ZdwXUNL/FfXUop3Zn460sua+Kshid9cyK3FlqDwqL9S9aVDqJZJrmSIdu0GBLv0D5hiO/XkgtIYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771802963; c=relaxed/simple;
	bh=ATwR8sRtUKq2KmqIcgmMZdgfm9GhLvf4rBSqx1EC3Ug=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=hc0FP4uB0+oop+BrWbPS68ZLymLQeadKazSYu8KyrFjnt7c8wxk0l5Xo8K0f21fLZjEqIXEZ0pDyj9SvemrRMR1rZhux1HJuuCS6NN+CuEgNKtj7+qTbuUHIigaEIeYDY8bQqdxdHBIPwCR6OIEMI2G4wYGv/jo7LeXm1L1/ceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LP8o8XpF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP8o8XpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771802961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1jtoMQqB3kszPAWZbBwURL5xlhEu+UeRdKKwqluzquU=;
	b=LP8o8XpFB8C/O+RJZhcjXwUAJbhdEKE0Sk1UwfkuSfH4A+0jq+qd6DT7E8U2XfullKytZy
	HmlsURjk7I2XIMe9OvwpqUyh7PtKjwymYyQUAr+Dol5Id7QwJnIIKLhUPzRgs7pB6tbcHr
	++hzhBmtP92dFVnoQViwHmxxInsyp4s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-KiBK3KjDMJ2QCchgK7T-aA-1; Sun, 22 Feb 2026 18:29:20 -0500
X-MC-Unique: KiBK3KjDMJ2QCchgK7T-aA-1
X-Mimecast-MFC-AGG-ID: KiBK3KjDMJ2QCchgK7T-aA_1771802960
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-896f50f008eso500138586d6.0
        for <linux-serial@vger.kernel.org>; Sun, 22 Feb 2026 15:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771802960; x=1772407760;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jtoMQqB3kszPAWZbBwURL5xlhEu+UeRdKKwqluzquU=;
        b=TiDd2WxhwlecDx6VTXslxg8y5PVvzYCFWzHUirbYsg9ekW2wGllbouaDRUJJJP1EMb
         e4DdhtVz7RHwdeSG+IVseZhPph8mgbdjMCg8FJ6K85ktEZwn416DSHjCB6n3mLXfGEsc
         IEKaHyeiDJPfGqX9xpajSVBWQoD6uHFlxTna9TBaiJYIYDRqYgU1m7jcR1Kx1xL6Hryf
         pO6uvt3POT8rg63BKpW0ergeQnenkaECLjmwkL3/UM+mef9TB08+PeZvYRpU4z2l1l1r
         GQMFuQ//epCbqItXza7J+Df1v9BuqjhaHKjqdBoYliaKsUYig6DcEFgMhh9hueX4i+xc
         6KTw==
X-Forwarded-Encrypted: i=1; AJvYcCXTj9K/SOvGJUoTEBaTrs1q1knueaOlnQDQipyK2IeI5vMXS3AdbFZ27pntXUy/C9I1U5p26UTXsGUPnJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFO/iSLmKG7Yb2W1uMe0a2rde5jyqxeSQ4VmOnDZ35syS1uzX
	FHPOZCXAtUD6xyN3PL+FB4DWOstM5vLZ2GYKqxMRweKMiOcv9Q2NpBe6GLy5xSAfrubRCxJkf+g
	Cpqv4dQB+/geNMwctIVkxc7fpXWTQTuLPyVtXdFc5/SJGkBb+zWA6OSIRC80tRTUroAsMfzMDh8
	SRMI2IqDkyf/OKvm3/p3Bsx1UXh7uC/zP9x9h/voNUnFO2bV/q
X-Gm-Gg: AZuq6aLs8yEhnMQ/pY92Px0PLzRuV7+FC/mWOHr24NpUINPLdFemxYTqljlskzWiWvz
	95HSRzGIWK5c3UpB5NJpEH/q6D9sog82JHbwEAZK3C2bPhkYm0fMu6Mjf50uJAwcprPrR5JXhmg
	/ioVBsNuaNxkOoCuX783TMEfoUvwBh3KfHbyaUG8C/pBAqHIPXG3qbSQo52foDSc9Bp91pAWlha
	GotcDVctCki5OzGWwuOKMivAE9R8Bm351TeunAFLBTnAWZEZybpqgzNtmi6dkGtpEDk407Jvk7t
	pJ9w/4w377yNnPtV7zq0slleD16WELMz6WBy0lM5cuml+2ANjdB6YZAyt4jF9pWIdIqn9g+QxWB
	cRY7r894v3RaN721vMfHmkUqeyXX6z2YsBIX4/5L9sXPeNwHrtutLhHpVrNneMA==
X-Received: by 2002:ad4:5747:0:b0:894:6f05:3185 with SMTP id 6a1803df08f44-89979b43a4bmr93741656d6.0.1771802959972;
        Sun, 22 Feb 2026 15:29:19 -0800 (PST)
X-Received: by 2002:ad4:5747:0:b0:894:6f05:3185 with SMTP id 6a1803df08f44-89979b43a4bmr93741426d6.0.1771802959427;
        Sun, 22 Feb 2026 15:29:19 -0800 (PST)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6bba49sm60062036d6.15.2026.02.22.15.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 15:29:18 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 22 Feb 2026 18:29:08 -0500
Subject: [PATCH] serial: pic32_uart: allow driver to be compiled on all
 architectures with COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260222-serial-pic32-v1-1-8fdbc0d0d334@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMjXZD6xBzdgsxkYyNdk6TkFAPLFFMjSwtjJaCWgqLUtMwKsHHRsbW
 1APNLjs5eAAAA
X-Change-ID: 20260222-serial-pic32-4bcd09d52983
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=ATwR8sRtUKq2KmqIcgmMZdgfm9GhLvf4rBSqx1EC3Ug=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJnT/S+qKV351bKivthob8jX75/u1VtScHauMAJJks5T
 u8VSjrypqOUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJNO1gZGhYxBD2/WWa2Wut
 nnXfA/fpFn1YLf39zaXO7LjV8pduKuQwMrz4/Od/PT//47qN+f7yrnbn9M4HXLb5r/0kZVXO8xV
 zP7AAAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XAF913a2c7T3za8j-3d4WjrJPD1ZUH1nQLNshwYjBLc_1771802960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This driver currently only supports builds against a PIC32 target, or
with COMPILE_TEST on MIPS. Now that commit 24cad1a22848 ("serial:
pic32_uart: update include to use pic32.h from platform_data") is
merged, it's possible to compile this driver on other architectures.

To avoid future breakage of this driver in the future, let's update the
Kconfig so that it can be built with COMPILE_TEST enabled on all
architectures.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f86775cfdcc9eb2013006b28b630252bf7e947a2..69d9760da0efbd2388f28ebfa01050727b701140 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -803,7 +803,7 @@ config SERIAL_CPM_CONSOLE
 
 config SERIAL_PIC32
 	tristate "Microchip PIC32 serial support"
-	depends on MACH_PIC32 || (MIPS && COMPILE_TEST)
+	depends on MACH_PIC32 || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  If you have a PIC32, this driver supports the serial ports.

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260222-serial-pic32-4bcd09d52983

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

