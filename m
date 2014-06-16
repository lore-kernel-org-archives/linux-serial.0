From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH tty-next 07/22] tty: ipwireless: Remove tty->closing
 abort from ipw_open()
Date: Mon, 16 Jun 2014 16:09:30 +0200
Message-ID: <20140616140930.GR1903@suse.cz>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-8-git-send-email-peter@hurleysoftware.com>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59806 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbaFPOJb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jun 2014 10:09:31 -0400
Content-Disposition: inline
In-Reply-To: <1402924639-5164-8-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Kosina <jkosina@suse.cz>

On Mon, Jun 16, 2014 at 09:17:04AM -0400, Peter Hurley wrote:
> tty->closing cannot be set on ipw_open() because the ipwireless tty
> driver does not call any functions that set tty->closing.
> 
> CC: Jiri Kosina <jkosina@suse.cz>

Acked-by: David Sterba <dsterba@suse.cz>
