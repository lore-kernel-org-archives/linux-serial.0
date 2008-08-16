From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: BUG: parport_serial in 2.6.27-rc1 for NetMos Technology PCI
 9835
Date: Fri, 15 Aug 2008 17:13:49 -0700
Message-ID: <20080815171349.fbebd261.akpm@linux-foundation.org>
References: <3f9a31f40808050800h7073b82al1342f7e23cf1e1b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58977 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368AbYHPANv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Aug 2008 20:13:51 -0400
In-Reply-To: <3f9a31f40808050800h7073b82al1342f7e23cf1e1b3@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jaswinder Singh <jaswinderlinux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 5 Aug 2008 20:30:10 +0530
"Jaswinder Singh" <jaswinderlinux@gmail.com> wrote:

> /dev/ttyS1 and /dev/ttyS2 of NetMos Technology PCI 9835 is giving Junk
> characters in minicom but /dev/tyS0 is working perfectly.

Is this still the case in 2.6.27-rc3?

Was the same bug present in 2.6.26?  2.6.25?

Thanks.
