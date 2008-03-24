From: "Kevin Wilson" <Kevin.Wilson@comtrol.com>
Subject: Nevermind -> (Baud rates > 460k)
Date: Mon, 24 Mar 2008 09:37:37 -0500
Message-ID: <B1F576FE19C55C43B8D2E31F061B50C0C4BC71@exchange.comtrol.com>
References: <B1F576FE19C55C43B8D2E31F061B50C0C4BC6C@exchange.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exchange.comtrol.com ([204.73.219.163]:22793 "EHLO
	Exchange.comtrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612AbYCXOgl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Mar 2008 10:36:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <B1F576FE19C55C43B8D2E31F061B50C0C4BC6C@exchange.comtrol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Found where the driver was attempting to determine the baud rate on its own instead of simply using the tty_get_baud_rate() api call. 

-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Kevin Wilson
Sent: Friday, March 21, 2008 10:57
To: linux-serial@vger.kernel.org
Subject: Baud rates > 460k


The termios functions cfseti/ospeed map 500k & 921k to 150 & 300 respective. For some strange reason the 460k works but higher speeds do not. Is this a bug that hasn't surfaced yet or am I missing something basic?


#define  B150	0000005
#define  B300	0000007
#define  B460800  0010004
#define  B500000  0010005
#define  B921600  0010007
--
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
