From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add support for the nwp serial device
Date: Thu, 20 Nov 2008 09:13:45 -0500
Message-ID: <20081120141345.GA2410@yoda.jdub.homelinux.org>
References: <200811201501.24000.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:60272 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbYKTOOE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2008 09:14:04 -0500
Received: by qyk4 with SMTP id 4so416730qyk.13
        for <linux-serial@vger.kernel.org>; Thu, 20 Nov 2008 06:14:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200811201501.24000.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, Benjamin Krill <ben@codiert.org>, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Nov 20, 2008 at 03:01:23PM +0100, Arnd Bergmann wrote:
>From: Benjamin Krill <ben@codiert.org>
>
>This patch adds support for the nwp serial device which is connected to
>a DCR bus. It uses the of_serial device driver to determine necessary
>properties from the device tree. The supported device is added as serial
>port number 84.

What does 'NWP' stand for, and how is it different from a regular serial
port?  Also, what platforms can this device be found on currently?

Some of that should be included in the changelog, but I'm curious as well
too.

josh
