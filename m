From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH -next 0/9] tty: Fix buffer work access-after-free
Date: Tue, 4 Dec 2012 08:54:26 +0000
Message-ID: <20121204085426.389ca79b@bob.linux.org.uk>
References: <1354604865-10278-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51164 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab2LDIvy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 03:51:54 -0500
In-Reply-To: <1354604865-10278-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue,  4 Dec 2012 02:07:36 -0500
Peter Hurley <peter@hurleysoftware.com> wrote:

> This patch series addresses the causes of flush_to_ldisc accessing
> the tty after freeing.

Looks good to me. Would be nice to keep a copy of the test that shows
it up in the comments of the patches somewhere.
