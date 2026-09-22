Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789854DADD
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084034; cv=none; b=b8SRofSlNAKZQ7RUgGscIFo/aUoCBHcoF5Nhz76iqa3uEISFOQzCTqrLw7XZljzFU9KTleDQtN3RmQIgkxxndQ3JRPR2vHJN5KpsisKf7TuntIhDRDxFWqfXdNsaoVRh2vPOFnCPkl/UNnrx13Imt4vfsyP3VVLhiKPF9+39kYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084034; c=relaxed/simple;
	bh=H8SjBKeODkYJuB20OhnIYOCLI18toT67xX3EcancdDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdL8iDh88SD8o30zucqLIi63r6cokK9yuZrV+YnXUX+pgzEzTuueRSQQnAnkR07bDxx2kW0XJNWrkxQKlVkpYH0xKp5VqWR2X4L9NLbxxm/bkmF0CbVmcoUv3/C6HfqcoPZ5ntgfrj7fbd7xhtMmS8HKgrHASWx9ZMGc+lLIaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SVnz+QT3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SVnz+QT3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so25590665e9.1
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790084024; x=1790688824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
        b=SVnz+QT3I8ti62UzKDZqWI/t/Ky8xoFhL/3ym9+SybegBOVx489WKl0Qmri75qAh5j
         2h4w0vDlkamxb91ed6rPprLijfZS8iG+Ez0ysiNzq6ESv/pO3wsX9198r+RUn29Pk9zu
         V0prKgj3LREUVnYNIljsGZhmnFPcFKW0rxxbl4gU5noyCFbKbNTImO6yuszOBYTsZIiu
         i/CMicwx8ge90zMlR/fhX6ZhD0Bc8vvtCj+e6HBur2gehQuYIGy3/KXRXnGgHZH6GoCR
         Zjn1eq18uIU1kA7arVlw5BdCjlhLyqFDAwIi4Jar0+Q3zg876y979pZdYSnhcauvbbMQ
         8fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084024; x=1790688824;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
        b=mb+aBrgGmBk7zez8DjutdZ9FGLz7myqsSSfd09QXNfdHpae2Ido8a5unzjf/yUX1XJ
         JX7IJFA9el7DHU3UICt1ZtuarU/1hrZl1A9jgE9FL/UqQMfeWJIJbdfoL4xYAxyIwr/8
         WouDbZtswqfsOGvSHOl05mdSiY3xg44Q47Z84WOQKfBqSt/kSX1X4hLmTj90fy0XpKIA
         ReIlupVJHYPoh3ajgx+SVG8JTFwdj0X/4pK0wLfJKYwbNiDJQ8s/a0GTjjY3g+s5NEgv
         0/leQme1Sg8ISPSjxaVhhCQJcSQxhgvrsKiw7kCKIkr0rvkZD67IKv4gaY89qGjPAMjp
         Rb0w==
X-Forwarded-Encrypted: i=1; AKwUvBwMGOaRBrtdi10GwtfFFg2MVd3mrJhioBxiF3DPtQ/5l9VPMnUDg9XOZFvet4ZcVY8bw7a2UfvKzpsFlM8=@vger.kernel.org
X-Gm-Message-State: AFuF++nrDRCFWAmnpOmPY8Lx5npvsoHykh6HoCgagGEeIentsfq1HXHV
	Lj/w6KDsi1j/A9sxGnsVyfm0jOSG5pIWPyYgT+RwcNk4Wn2zDkmLTPdZPRp8zgX55xc=
X-Gm-Gg: AYBFou0zpM7JHJ25pHQTCwvTBBVwK2EBISV+yZO+T10CSQWOwuILUujU1nyA7Wy4q5/
	4xPo3kBeICQzOzswI3Q+oSOFZnc6hW9I5mByx4SH+/wgbk5PYYnla6Dwuuq6nPOCQdzfvXSUTYc
	kul4UR48zmnJJc7/z2k9Jkd2d+VNYwtn05VI9o7EzTUdnzwcCT1MbCxEqLGKUrCSalm9XMChTCm
	O5G2ClXZBR5ByPnE7EY/OpCfbd3YGti04k+/o6nBCM7EMoFVS1A+4AUF/sllVkc1IyT1vFMYAMK
	k9fvZkS0KL8jwBF7wfp3CO2QIIOTSCOO/3hjSwzhEjp7444h8g56V5suxGW1jtXHmGGCzxDRneI
	GuiePu4AQezFLiEWem4j5FQQsHcjN+8aOsdhgOHx4UkkSm11XO3mIYpC2mER0XqkD3YTiWS+qCi
	2Y6Ywo7XyW5RypygZaXs/1TEw+aFpNCOLXzRjMo9abURDx7S486iSxNdTDrI58oStjUd+aSxLal
	jFkzhDOo2Pie/KHNUx5OcGRB0uhO4pwyYvEwJDDDwpCF/+NeED97nDZpZiZD1Kdrzj3G1E=
X-Received: by 2002:a05:600c:81c8:b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49fc58581bfmr184348345e9.31.1790084023989;
        Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
Date: Tue, 22 Sep 2026 15:32:23 +0200
Message-ID: <20260922-module-string-v1-3-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-module-string-v1-0-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Remove __MODULE_STRING() now that all remaining uses have been replaced
directly with __stringify().

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..0d9157a2d487 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -886,10 +886,6 @@ extern const struct kobj_type module_ktype;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
-/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-
-#define __MODULE_STRING(x) __stringify(x)
-
 #ifdef CONFIG_GENERIC_BUG
 void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);

-- 
2.55.0
