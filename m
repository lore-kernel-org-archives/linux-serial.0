From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: What happens with chars in input buffer on open
Date: Mon, 25 Jul 2005 12:01:35 +0200
Message-ID: <17124.47231.961026.383844@hertz.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:52996 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S261174AbVGYKBj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jul 2005 06:01:39 -0400
Received: from hertz.ikp.physik.tu-darmstadt.de (hertz.ikp.physik.tu-darmstadt.de [130.83.24.91])
	by elektron.ikp.physik.tu-darmstadt.de (8.11.2/8.11.2/SuSE Linux 8.11.1-0.5) with ESMTP id j6PA1cJ16659
	for <linux-serial@vger.kernel.org>; Mon, 25 Jul 2005 12:01:38 +0200
Received: from hertz.ikp.physik.tu-darmstadt.de (localhost [127.0.0.1])
	by hertz.ikp.physik.tu-darmstadt.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id j6PA1axp021923
	for <linux-serial@vger.kernel.org>; Mon, 25 Jul 2005 12:01:38 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hallo,

is there any POSIX defined behaviour with characters already pending in the
input buffer when the port is opened?

The observation with some program (Wine) is that these characters are not
discarded. A read() returns these characters. This may be caused by some
settings that another Wine process has done before. Which parameters might
cause that behaviour?
But at least
port.c_lflag |= NOFLSH
seems to have no effects.

Thanks for any help/pointers

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
