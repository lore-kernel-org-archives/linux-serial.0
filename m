From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/7] serial: sh-sci: restore big-endian operation.
Date: Fri, 9 Mar 2012 09:10:07 -0800
Message-ID: <20120309171007.GA25965@kroah.com>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
 <1331311133-26937-3-git-send-email-thomas@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44838 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758275Ab2CIRKM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Mar 2012 12:10:12 -0500
Received: by gghe5 with SMTP id e5so974889ggh.19
        for <linux-serial@vger.kernel.org>; Fri, 09 Mar 2012 09:10:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331311133-26937-3-git-send-email-thomas@codesourcery.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Mar 09, 2012 at 05:38:49PM +0100, Thomas Schwinge wrote:
> As of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
> endianess-agnostic I/O accessor functions.

Please always put a human readable description of what the git id is, so
that we have a chance to understand what is going on.

Are these patches supposed to be going through the sh tree, or the
serial tree to Linus?

And watch your To: line, it seemed to be munged :(

confused,

greg k-h
