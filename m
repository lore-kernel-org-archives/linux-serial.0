From: Roel Kluin <12o3l@tiscali.nl>
Subject: questions regarding function autoconfig(); drivers/serial/8250.c
Date: Fri, 23 Nov 2007 23:42:38 +0100
Message-ID: <4747575E.80501@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:47750 "EHLO
	smtp-out1.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102AbXKWWml (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Nov 2007 17:42:41 -0500
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out1.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IvhEO-0001Dw-Lh
	for <linux-serial@vger.kernel.org>; Fri, 23 Nov 2007 23:42:40 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

In drivers/serial/8250.c:995 it reads:

if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
	return;

As you can see the test !up->port.mapbase is duplicated, which makes no sense.
maybe a different test was intended here?
also since membase is a pointer shouldn't the '&&' be replaced with '||'?

thanks,

Roel
