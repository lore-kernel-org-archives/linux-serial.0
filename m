Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="D7AXvMTX"
Received: from mxe-2-adb.seznam.cz (mxe-2-adb.seznam.cz [IPv6:2a02:598:64:8a00::1000:adb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB2F9;
	Tue, 21 Nov 2023 00:28:31 -0800 (PST)
Received: from email.seznam.cz
	by smtpc-mxe-b7dc65f8c-m6chn
	(smtpc-mxe-b7dc65f8c-m6chn [2a02:598:64:8a00::1000:adb])
	id 7e5e3ab780aa881d7ed0b4af;
	Tue, 21 Nov 2023 09:28:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1700555293;
	bh=ji2dMfHgLE3waElO8QAkAB5krWMcZPVPZP+nJi3UQt4=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=D7AXvMTXM2WuFMz3JfMg9Usx782zt6mvPljekAsbggigslcnFBw4NIrR/5zc+101Q
	 wuVp8Xq596y73jXC0cth2MwJDtUyW8p2qqBOdO4QFcap/mjroqnRvEaZA2gBdCeUgw
	 pERgCHCdlhw7CYyso97OxXagSXHkpwnpJRYUiEYBUDty+2ThipHCTAbr9Pc5JY83wJ
	 PgJ2FYUhh4ejI/nZlJAaEIyrZk4dCeUSFhDMG1wJ8HcHSHzn+fYPFJcpc4kjYgsRnj
	 7N4sOXDuFSMnBWhPFvmsmSXk8pz2ppgYwM7a7qGwJJNkKrFLUQnQk/oL8qJJ20VswA
	 R+AJF13uk8gJA==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Tue, 21 Nov 2023 09:28:12 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Conor Dooley" <conor+dt@kernel.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: =?utf-8?q?=5BPATCH_v4_2/2=5D_dt-bindings=3A_serial=3A_Add_support?=
	=?utf-8?q?_for_enabling_RS485_mode_via_GPIO_at_boot_time?=
Date: Tue, 21 Nov 2023 09:28:12 +0100 (CET)
Message-Id: <3Zb.ZZsn.wkax8K4so6.1bN6eS@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an option to enable the RS485 mode at boot time based on
the state of a GPIO pin (DIP switch or configuration jumper).
The GPIO is defined by the device tree property "linux,rs485-mode-gpio".=


Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documen=
tation/devicetree/bindings/serial/rs485.yaml
index 9418fd6..7a72f37 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -47,6 +47,10 @@ properties:
       later with proper ioctl.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  linux,rs485-mode-gpio:
+    description: GPIO pin to enable RS485 mode at boot time.
+    maxItems: 1
+
   rs485-rx-during-tx:
     description: enables the receiving of data even while sending data.=

     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.7.4
 
