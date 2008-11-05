From: Jan Engelhardt <jengelh@medozas.de>
Subject: Arbitrary port selection for 8250
Date: Wed, 5 Nov 2008 15:28:38 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811051525070.18424@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:47067 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbYKEO2k (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2008 09:28:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 6CFBB1C12C406
	for <linux-serial@vger.kernel.org>; Wed,  5 Nov 2008 15:28:38 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I happen to have a serial device at an odd port, and have not found any
module_param in linux/drivers/serial/*.c that would allow me to 
manually specify an I/O port. Would anyone know how to teach 8250 about 
it without tampering with the source?

thanks,
Jan
