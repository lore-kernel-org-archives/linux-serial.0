From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/3] parisc/uapi: Add definition of TIOC[SG]RS485
Date: Tue, 9 Sep 2014 11:58:52 -0700
Message-ID: <20140909185852.GA7037@kroah.com>
References: <1410285991-24833-1-git-send-email-ricardo.ribalda@gmail.com>
 <20140909184318.GA6231@kroah.com>
 <CAPybu_3wJ+UPbnkWPFLJdne6Rz8ouUap3E1GeA9NqX=gP4fPug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPybu_3wJ+UPbnkWPFLJdne6Rz8ouUap3E1GeA9NqX=gP4fPug@mail.gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 09, 2014 at 08:46:48PM +0200, Ricardo Ribalda Delgado wrote:
> Hello Greg.
> 
>  I have just resend one for sparc. Are we sure that we prefer the
> macros instead of using the same value on all arches?

Why would using a macro preclude the value being the same on all arches?
