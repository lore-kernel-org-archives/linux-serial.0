From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v5 00/44] ldisc patchset
Date: Thu, 14 Mar 2013 07:42:39 -0400
Message-ID: <1363261359.25976.224.camel@thor.lan>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
	 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
	 <CANN689HvZK3gHyxRBPZyXwz2cJfheiEoQMA23oRARMCp=7GUCQ@mail.gmail.com>
	 <1363106846.27803.174.camel@thor.lan>
	 <CANN689HX1VAURYZL4=ixOSwim2LdYDgZyORtfUffrc4JCqK4xQ@mail.gmail.com>
	 <1363223574.25976.135.camel@thor.lan>
	 <CANN689Fe7K-+Mf1is9GaS0bjDuYaTd8AtBMjLvAVAkNy+QLmuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANN689Fe7K-+Mf1is9GaS0bjDuYaTd8AtBMjLvAVAkNy+QLmuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Lespinasse <walken@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2013-03-14 at 00:25 -0700, Michel Lespinasse wrote:
> On Wed, Mar 13, 2013 at 6:12 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> > On Wed, 2013-03-13 at 04:36 -0700, Michel Lespinasse wrote:
> >> Have you considered building your ldlock based on lib/rwsem-spinlock.c
> >> instead ? i.e. having an internal spinlock to protect the ldisc
> >> reference count and the reader and writer queues. This would seem much
> >> simpler get right. The downside would be that a spinlock would be
> >> taken for a short time whenever an ldisc reference is taken or
> >> released. I don't expect that the internal spinlock would get
> >> significant contention ?
> >
> > That would have been too easy :)
> >
> > TBH, I hadn't considered it until I was most the way through a working
> > atomic version. I had already split the reader/writer wait lists. And
> > figured out how to always use the wait bias for every waiting reader and
> > writer -- rather than the rwsem way of testing for an empty list --
> > which made the timeout handling easier.
> >
> > At the time, the only thing that I was still struggling with was
> > recursion, and the spinlock flavor wasn't going to fix that. So I just
> > kept with the atomic flavor.
> 
> Its not too late to run away from it and preserve your sanity (as well
> as that of the next person working on the tty layer :)

The long-term plan is to migrate it to lib so it won't be a maintenance
burden to tty.
