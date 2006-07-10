From: Kevin Wilson <Kevin.Wilson@comtrol.com>
Subject: Throughput test fails on FC 2.6.15 ttyS0
Date: Mon, 10 Jul 2006 09:11:47 -0500
Message-ID: <DD5056872F0E6A4EB8555318C3F8BCB00B62E8@exchange-2.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exchange-2.comtrol.com ([204.73.219.38]:14601 "EHLO
	Exchange-2.comtrol.com") by vger.kernel.org with ESMTP
	id S1030387AbWGJOLu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Jul 2006 10:11:50 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Running a loop back test for throughput using a program we have here ttyS0
fails. Plugging in SuSE 10 and running the same test it passes. FC 2.6.15
includes the new tty layer changes made by Alan while SuSE 10 still uses the
old. Has anyone else experienced this?

thanks,

Kevin
