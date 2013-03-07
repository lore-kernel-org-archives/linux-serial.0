From: Josh Boyer <jwboyer@redhat.com>
Subject: Re: 8250.nr_uarts broken in 3.7
Date: Thu, 7 Mar 2013 13:58:11 -0500
Message-ID: <20130307185810.GG13719@hansolo.jdub.homelinux.org>
References: <20130307185642.GF13719@hansolo.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3CGS64 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Mar 2013 13:58:56 -0500
Content-Disposition: inline
In-Reply-To: <20130307185642.GF13719@hansolo.jdub.homelinux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 07, 2013 at 01:56:42PM -0500, Josh Boyer wrote:
> Hi All,
> 
> We've had a report [1] in Fedora that the nr_uarts parameter on the 8250

Sigh.  Link to the report:

https://bugzilla.redhat.com/show_bug.cgi?id=911771

josh
