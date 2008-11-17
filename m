From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: RE: serial8250_interrupt idea
Date: Mon, 17 Nov 2008 09:08:43 -0500
Message-ID: <004801c948be$01525990$03f70cb0$@com>
References: <16F7A0434C94480694C28863602B42A0@acksys.local> <20081117134504.22912.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:4835 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbYKQOO1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2008 09:14:27 -0500
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id mAHE9CPV017021
	for <linux-serial@vger.kernel.org>; Mon, 17 Nov 2008 09:09:12 -0500 (EST)
	(envelope-from cdore@connecttech.com)
Received: from cdore ([206.130.75.122]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id mAHE8ld18896 for <linux-serial@vger.kernel.org>; Mon, 17 Nov 2008 09:08:47 -0500 (EST)
In-Reply-To: <20081117134504.22912.qmail@science.horizon.com>
Content-Language: en-ca
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

> George Spelvin wrote:
> In other words, your step 4/ cannot actually happen.

What if you consider interrupts of higher priority occurring?  That could
cause delays in your servicing of X.  I've encountered this before with high
speed ports on multiple interrupts, where one port continually steals time
from another.

..Chris


