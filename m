From: "Lewis Brown" <lewisb@denveronline.com>
Subject: Best way to detect received call on dumb modem ...
Date: Sat, 1 Nov 2003 13:43:23 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <000001c3a0b8$ce82efa0$0200000a@francois>
References: <20030909235153.GB4559@ip68-0-152-218.tc.ph.cox.net>
Reply-To: <lewisbrown@acm.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.firstlink.com ([66.37.141.15]:62685 "EHLO
	mail1.firstlink.com") by vger.kernel.org with ESMTP id S263434AbTKAUnj
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Nov 2003 15:43:39 -0500
Received: from francois (lewis.brown [66.37.132.7])
	by mail1.firstlink.com (Postfix) with ESMTP id 42E991259B9
	for <linux-serial@vger.kernel.org>; Sat,  1 Nov 2003 13:43:38 -0700 (MST)
In-Reply-To: <20030909235153.GB4559@ip68-0-152-218.tc.ph.cox.net>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I'm trying to detect incoming calls on a dumb modem but dealing with a
driver that doesn't implement TIOCMIWAIT or TIOCGICOUNT. I'm puzzled how
best to go forward in an efficient way.

Any help would be greatly appreciated.

lb


