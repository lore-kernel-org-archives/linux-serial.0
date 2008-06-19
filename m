From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: serial8250 and platform port power management
Date: Thu, 19 Jun 2008 14:32:14 +0200
Message-ID: <20080619123214.GA21515@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:39843 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102AbYFSMcS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Jun 2008 08:32:18 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hello,

struct uart_8250_port has a pm() callback for port powermanagement.
Is there an existing way to assign this callback for a group of
8250 ports registered as platform_devices?  Looking at the source 8250.c
I actually couldn't find any users of it.

Thanks,
	Manuel Lauss


