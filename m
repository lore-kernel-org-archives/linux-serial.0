From: Jamie Iles <jamie.iles@picochip.com>
Subject: Resend of [PATCH] 8250: add a UPIO_DWAPB32 for 32 bit accesses
Date: Mon,  4 Jan 2010 17:19:30 +0000
Message-ID: <1262625571-23800-1-git-send-email-jamie.iles@picochip.com>
References: <1262625116-22712-1-git-send-email-jamie.iles@picochip.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail2.picochip.com ([82.111.145.34]:48557 "EHLO
	thurne.picochip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752122Ab0ADRSV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jan 2010 12:18:21 -0500
Received: from localhost.localdomain (wear.picochip.com [172.17.1.47])
	(authenticated bits=0)
	by thurne.picochip.com (8.13.8/8.13.8) with ESMTP id o04HIFhv024028
	for <linux-serial@vger.kernel.org>; Mon, 4 Jan 2010 17:18:19 GMT
In-Reply-To: <1262625116-22712-1-git-send-email-jamie.iles@picochip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

The original patch was whitespace broken for 8250_early.c. The following
patch addresses the brokenness.

Jamie
