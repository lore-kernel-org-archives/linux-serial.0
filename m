Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2412F38A
	for <linux-serial@vger.kernel.org>; Tue,  9 Apr 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671091; cv=none; b=OUT/hXLKBkunEH6kVoQXVc1HSXy3WBRfkNmFmDcg5xcWlSZbN7coqOTTIpIh7eeI2mBHv720rkps3eslWZ915DwiZOFwPVkWtomoYuyggMlFNqTM3udbJEYWG5VhDe/tvXSVOR0KvJx2er7ACm1gSnCG/+gplnbUoovPmLAiwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671091; c=relaxed/simple;
	bh=DKYSigMpkoU8bet8GKBg0SRhNvZ5v4fCCMF1OiXo7TY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=k16yAoN6bC7p8doWpSSNixeaQsQfk0jsxXcbaYEW3xTxgKE8xWx5JPB8XOKdJCC9q9tdse7pqyzyTrpm3TtZJpn2S2iw/Okk83SLrtPHhRtG/BKEK/cN3wrSfNCDAHmSVSZAphyPQaE2Yqe44AECWDDOWBJxrwlpy98Inv46nDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yT9+lSe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yT9+lSe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82703C433C7;
	Tue,  9 Apr 2024 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712671090;
	bh=DKYSigMpkoU8bet8GKBg0SRhNvZ5v4fCCMF1OiXo7TY=;
	h=Subject:To:From:Date:From;
	b=yT9+lSe/VLoKf2dlk9mw7UEaOe+kmRqjTNB53iFqELvPajeXkUh/bEFzViKw+LBKn
	 u9Qv4rSmbJvjtscLavYRxVxDYIQUBHQeO0iAZSvajkGGOuwzsi517VGfMdSCwdA9TE
	 OtZAHKkH1TDHef5eXEYXpgUipF6c/zSPpdG83b3Y=
Subject: patch "serial: 8250_pci: Remove redundant PCI IDs" added to tty-linus
To: andy.shevchenko@gmail.com,gregkh@linuxfoundation.org,jimand04@hotmail.com,linux-serial@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 09 Apr 2024 15:58:01 +0200
Message-ID: <2024040900-postnasal-basics-79dd@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: 8250_pci: Remove redundant PCI IDs

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 90452456eb69297fe7ae34e56e40d8e47dc9e019 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 01:41:52 +0300
Subject: serial: 8250_pci: Remove redundant PCI IDs

Driver complains that PCI IDs are not needed for some of the LAVA cards:

[    0.297252] serial 0000:04:00.0: Redundant entry in serial pci_table.
[    0.297252] Please send the output of lspci -vv, this
[    0.297252] message (0x1407,0x0120,0x0000,0x0000), the
[    0.297252] manufacturer and name of serial board or
[    0.297252] modem board to <linux-serial@vger.kernel.org>.

Do as suggested.

Reported-by: Jimmy A <jimand04@hotmail.com>
Closes: https://lore.kernel.org/r/VI1P194MB052751BE157EFE9CEAB75725CE362@VI1P194MB0527.EURP194.PROD.OUTLOOK.COM
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20240403224152.945099-1-andy.shevchenko@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0d35c77fad9e..e2e4f99f9d34 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5010,12 +5010,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATTRO_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATTRO_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_4_460800 },
-- 
2.44.0


