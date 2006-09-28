From: Alan Cox <alan@redhat.com>
Subject: Re: few questions on mxser driver (cleanups)
Date: Thu, 28 Sep 2006 12:20:34 -0400
Message-ID: <20060928162034.GA11165@devserv.devel.redhat.com>
References: <1159459455.1709.66.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40172 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751884AbWI1QVG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Sep 2006 12:21:06 -0400
Content-Disposition: inline
In-Reply-To: <1159459455.1709.66.camel@dyn9047017100.beaverton.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: kernel-janitors@lists.osdl.org, linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk, alan@redhat.com

On Thu, Sep 28, 2006 at 09:04:15AM -0700, Badari Pulavarty wrote:
> 1) mxser_get_PCI_conf() and mxser_get_ISA_conf() doesn't check
> errors of request_region(). I think these should be checked and
> return failures. Can we treat request_region() failures as corresponding
> MXSER_ERR_* failures, instead of returning new error code (like -EIO)?

I've as much idea as you do, and no hardware to test sorry


