From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH v2 0/8] Some patches for Altera UART driver
Date: Fri, 1 Oct 2010 17:20:45 +0400
Message-ID: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44337 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab0JANUu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:20:50 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

Here is v2. Changes:

- Addressed comments by Alan Cox and Tobias Klauser;
- In patch 'Add support for getting mapbase and IRQ from resources',
  added ioremap() return value checking;
- Added a few fixup patches.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
