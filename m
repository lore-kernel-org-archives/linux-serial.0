From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] PCI: quirks, don't mark one netmos as class other
Date: Mon, 9 Feb 2009 09:17:26 -0800
Message-ID: <200902090917.26450.jbarnes@virtuousgeek.org>
References: <1228749555-21363-1-git-send-email-jirislaby@gmail.com> <498F558F.109@gmail.com> <20090208144537.ecf1019b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755490AbZBIRRn@vger.kernel.org>
In-Reply-To: <20090208144537.ecf1019b.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sunday, February 8, 2009 2:45 pm Andrew Morton wrote:
> On Sun, 08 Feb 2009 22:58:39 +0100 Jiri Slaby <jirislaby@gmail.com> wrote:
> > Jesse Barnes wrote:
> > > On Monday, December 08, 2008 7:19 am Jiri Slaby wrote:
> > >> Let it as serial, since it doesn't have subdevice in the form of
> > >> 0x00PS.
> > >>
> > >> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> > >> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > >
> > > Applied to my linux-next branch, thanks.
> >
> > Hi, did this get lost by a chance? I don't see it in your -next branch
> > anymore. Neither in any other branch nor upstream.
> >
> > BTW I got:
> > This patch was dropped because it was merged into mainline or a subsystem
> > tree from Andrew, so it had to be somewhere, I suppose...
>
> yes, it got lost.  I resurrected it.

Sorry I must have been thinking about another patch when I replied; the 
contents don't look familiar.  Anyway I'll pick it up now.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
