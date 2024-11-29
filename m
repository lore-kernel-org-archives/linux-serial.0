Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E6153828
	for <linux-serial@vger.kernel.org>; Fri, 29 Nov 2024 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854377; cv=none; b=DjlBt2IRpkCXXav4xJc8nxnQ/YlNWhQGRx1NubLve/xMi7NMQ7GQbzDV2IhTnZXw60PW8pDIU+uwWS9jRN9o7cDrbmwwsAS5+pVNkl82PVlbWUYXi3fyL+YkXRzonS/jRIMlA87lYBueAtlSMMz2d4KwOGrXbR7uulEx84LPajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854377; c=relaxed/simple;
	bh=At14nQ9bt4ZXGROW9mDC30YLZ5CMdzjPOgVAugksG4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9Dvuzgo2+iUI8lV+E1n0HmraMSA3HGoUJexiN4ppWueU3wLxGqkvh0/awIR5Xo3LoToHS4DPlnY2ARFzgY98gCEhBZ9J7rMVkjgcyGBgj5GGqC6BOoCr/S81A2bD6pV6h09uR2e52LAyhEthgPs/iq/FEPYKLaesdM7jnnNSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=LLv8C/Ta; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="LLv8C/Ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1732854369; bh=CcBr8CthFfnn4DMiOiwdM5Xy1AM8khizAvAFJ5en5HU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LLv8C/TaFU4cJlVsiP4dAKoc7U+eQU9Qbed/pe9MAQldDk/h/5pchjxXtUTM9OWf7zDeeUYAuO/XRU8RBrqEP0+6Z39SN5wupv6X3+uDuY2sbXXhJc0SUnJ3DvMqOONyb7fgbksSvb2NGqRm37NGqvNf+J2BqpXcl9l1qQXUzvtPdXefefVaYKmNhXGOOPGHOlyvHQc0n98tME5hthSdZdhoMnR+bINBkszblr+brlhfBdQsQyi50xRqWjGu2Az5LgUHTx/hFAmBEvNfHSDvdr7/OUAymX2tRcnXjJ7lcDC7r0p7SFS8VbwR+Ef/iblLgc+XzygopJlsdF5X5ybc+g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732854369; bh=yhUbPLRXFDaCayiA/Mjsho/asU5+jwUdlKZyiraicYF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UrCFtTZpWYS722XP7Ap7SxR3f6uL6e4EvjOj4oWFfFbTvbsmqyOWcd9WYUUudDffHVcXjBXdRtj8LkY5dMBCl9abB5e1Yot36ICoz27Foc9yg3Pim2Ysocor8RoepIKoYQ4vIRrJ3wZuFj09ZJRAIGEfIhgtZGpWfdtDBlckjOP5ExD9prAZ6nobxn4MiMzTE0EpleRSC230+zs5vEXVpoeEexWE6SADDOmcqmvnSPda7qNMPuazOYCk3Up07e0iCcYNjanQa/XshxuUjycbCN34YD/Hu6jEFiIfYxMwzJcClc8BVKXofzN5SuHOPSdfln/NVQ2bJxjS95MVn+3szQ==
X-YMail-OSG: 06Tdy_8VM1mpRmzWtSYPXcumG9Hh9.79lzmDdh9F6sbP3uwxUNG2BVEykE8.tMI
 vRsjY0jSLaaJ8nlzYoUjG8P7NLNDZMTxrSBLSqpIlqgkIpZHzEkK8RYezOZoRQrPFc0f3VH0e97n
 lqtl2WDROBKuGfIjW26N.YwoE5ijW6RBQUXFHUmhyCeAlCtmNgn3H_bsxjySQohtnQKoFOjjjJG.
 aJdKLfLfE4Nqcwa8FrrsBxZVPNB_TsAhTUX97jDGHXrjWlU3SSNe5xXF95CviuLwREMUl5mteZU4
 oxzqTV85H_iRbzP.1xcKUUpS5eLrxAvnT0JwGNoR3AlE01u3u0ThdgzHK72cG4X_w4ITRw.YWwQg
 AZ6RfxZ7iPv_thjyeCxXsNrk7Esyr39E4dVnFnYaw1ITv9sNtYIK_v_OjL9FGAWS7y5EXkVOs9KI
 zM9anJIB2Azj5_Jw2ZtC9AmLiaXH9y4UKCRzU5XyjIu8C.PgmTlxNfenOq1QcMQF8ZQiqUEGzP1k
 iBT3D5Lop9FBapShFEtQCyKF_n.SsIIEQrqBziqwVZrbz8o1Cf45I0CZ4N0xaB78caCq6uuk43dV
 6k_QHctk8J7ZlclCnyzwW_2tXs8rA_JjN_y3OWQMxWQyO8L5cfpXbtDuIEuGuCsW8hqEuDmy8Vis
 .LuCgf0C2Aduorgcq_OZiAsPluv1X.4KyZPo._q_w54jh7eTHz7BcK_A76dOHHcPRpAeAM.NCrTK
 DdGEgFUR6Wfsrj2o1c3Kp5lyqRv6QCkxFqDXKkUMQGuqjzMbkOBcg0MdJUDzP1GvG5qOIRWNzVuB
 Evx8ynFI2Jl0FkC8JukTf36lUNzHt0w3qaH4ZUlEWZxdvIeHhV2jLJZFJewACgsoVtoq6wgFjZfU
 nTwTDpXBu.7oVNtpLwWccen6P2138Y0MstPDDT9kWKXkR5FsF8eSl.trYuEg9_C2OP_WkhZihQF0
 C3uCHUIXWU6ZlCDYLQwjGNJaur_5wKnXxVn3aO8jhoIOydy9qcqzJ1xoLaVDWlM5a1bbyq3SL3Od
 fxIglL_YdueztVVE2Vt2c_ke8XZnXI8637XGpSlPGI2xLklgdor9.ugewexz1VTV0pnUOoWYs7tz
 N0Zjz4Qg3IINxJ237kg.XUGAxRDj72QIQRy9SUVLa8OS_EJI6jJr47KAHQTbDzAPT1n.NXKLBYiN
 vtgLll6X.I8TGush45bSWOngShRfKNkgdjycZBncku1InpNiBFuvpnrgFRl_W6fanh3JR0L8VwZU
 F6JpmiDipF3PaKgaHIBmhzEPAKKtA2NhHkfGz0bUAvmpH7AjFliCaxco7AJ2A49qUicHnU1DhO5.
 wpwbdA66FA8i3OmQxM_1OnL9N.KF4iod4AYZq6UrzqzbZy3V8_6blfPZXg8WpZL5OzoMuiGhgdQ8
 G5Vo8sNAjIfBlrQOez4jrKtRPEFlZY4TqhMrWQe32X.advsZXE4KIH_hf8e_entFen8VCe5jepoU
 7u02v5GDB5BSVmtiwfL8V6yeqNtiQPBMiNvJzUg._IlpeQQAZeVPDrogqaebRXZ_VbaFL4DA7K.J
 Fp32SwSEylaoNhieCryNJRtaoprVkMXxfr4HonmhY72hSqgnG_bMCyTvlXAcFJLDmvpTXxlHWc4B
 N2V1N39qpRARAYN3K.41a_2YYmyWm3gmzk987cwgm4Ncg4okPyZZnCAmEqhXFIbYWTo9XaTHhiGE
 FSXUM39Vu6x5E3tCkq36YPZ7AIqONvUtZ9L0fGjvtl3EBaerwRSvu3oqO7yO7HltmG7bxz8Vrwyu
 _xX_5gkA_4LdsDya7QF8x91UmuDTMR0oyTMlTrLiegU9O.ok9JuL3H8VnJPV0Fqkrvq4zrlidJ5i
 JUEaXgAhTOJAgl3CpS.JmlqRcxMegPUvVECLYBcV0sZwuIfjGssj9X2PU0R.Id84Dew29OBZH3Mo
 W0N.0Icy43jRd4Gc8YIkIXr9WmiNigej.anzi8u11BLZRKbR1hn5V2bgpTHg68BTMj5A4TQQycwy
 cHmq5RzUTVX0zCgpuAzMOfBvhstJ_jdlP299Ya568gFo.NKwKc.n.PRmn3WrA7XGXfZ3aMUv4ILu
 0eZN2k2PX_0F8Xqvtmhf10ZNbSCp2uiNXULW98K8gVU8c_LGYhZHCIIiOHf1nGQrQyVnH4EjZjgC
 ttY9y_hvFEOj6rpULXdLaVhmZyBocvUv.sAT.xJeMWBCSdhxyak.lSd05yaVrCzkgIjOsqo8e6cm
 l1p5roIgENs7JS3ek6kJ7iFziNG3UBJipfwPYT6SG7khCcQUuZGfv5xsTL.qIxOWlbMPJx.O1DAx
 0jXwEEwfOCCQAYH37zLk-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 00e5bcf1-ff1e-4af2-ac3a-38d045cad805
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 29 Nov 2024 04:26:09 +0000
Received: by hermes--production-bf1-66bb576cbb-h2pjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af1c0b40292d512b9d850181f2953147;
          Fri, 29 Nov 2024 04:15:59 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: n3rdopolis <bluescreen_avenger@verizon.net>
Subject: [PATCH 2/2] tty: Change order of ttynull to be loaded sooner.
Date: Thu, 28 Nov 2024 23:15:49 -0500
Message-ID: <20241129041549.778959-3-bluescreen_avenger@verizon.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
will become the default primary console device, based on the load order.
Users and distributions that are migrating away from CONFIG_VT will
benefit from this as /dev/console would not suddenly become /dev/ttyS0
which could otherwise cause some user space behavior changes, namely the
TCGETS ioctl failing, which causes libc's isatty() to incorrectly return
false when /dev/ttyS0 is disabled, and will prevent a device that is
connected to a user's /dev/ttyS0 to suddenly start getting kernel log
messages.
Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
---
 drivers/tty/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..03bb47e11e1c 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_N_GSM)		+= n_gsm.o
 
 obj-y				+= vt/
+obj-$(CONFIG_NULL_TTY)		+= ttynull.o
+
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
 obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
@@ -20,7 +22,6 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
-obj-$(CONFIG_NULL_TTY)	        += ttynull.o
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
-- 
2.45.2

