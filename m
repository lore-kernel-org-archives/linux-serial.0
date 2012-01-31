From: Greg KH <gregkh@suse.de>
Subject: Re: [GIT PATCH] TTY/serial patches for 3.3-rc1
Date: Mon, 30 Jan 2012 16:13:08 -0800
Message-ID: <20120131001308.GB20588@suse.de>
References: <20120130211241.GA12941@kroah.com>
 <CA+55aFxFtsOj+9RYQGj+WEk3ovg4+d_syn8TooKjvBq2_B463Q@mail.gmail.com>
 <CA+55aFxGf8-Bv8Jrhm1dbTg6AkTi37Vfuw5OOC7hDokKRa4hjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxGf8-Bv8Jrhm1dbTg6AkTi37Vfuw5OOC7hDokKRa4hjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 30, 2012 at 03:20:52PM -0800, Linus Torvalds wrote:
> On Mon, Jan 30, 2012 at 3:19 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Tssk. Your script is broken, or your manual fixup is broken. Look at
> > the tag-name again.
> >
> > I pulled the correct one, but please be more careful.
> 
> Oh, and if it's because your old script can't verify the tag-names, so
> you fix things up by hand instead of scripting it, try using
> "tags/<tagname>" instead of just "<tagname>". That makes old git
> versions at least see the reference, even if they don't then react to
> the signing itself (ie they just treat it as the commit it points to,
> rather than as a tag with interesting contents in itself)

Ah, ok, I'll try that out.

Or I can spend the time to get the new version of git installed.
Wrestling with my scripts or rpm, I don't know which is worse...

greg k-h
