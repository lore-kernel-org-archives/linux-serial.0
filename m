From: "Kevin Wilson" <Kevin.Wilson@comtrol.com>
Subject: Baud rates > 460k
Date: Fri, 21 Mar 2008 10:57:13 -0500
Message-ID: <B1F576FE19C55C43B8D2E31F061B50C0C4BC6C@exchange.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exchange.comtrol.com ([204.73.219.163]:49024 "EHLO
	Exchange.comtrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758921AbYCUP4T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2008 11:56:19 -0400
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

The termios functions cfseti/ospeed map 500k & 921k to 150 & 300 respective. For some strange reason the 460k works but higher speeds do not. Is this a bug that hasn't surfaced yet or am I missing something basic?


#define  B150	0000005
#define  B300	0000007
#define  B460800  0010004
#define  B500000  0010005
#define  B921600  0010007
