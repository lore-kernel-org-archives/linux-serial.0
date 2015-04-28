From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 01/13] of: earlycon: Fix 'stdout-path' with ':' path
 terminator
Date: Tue, 28 Apr 2015 15:28:38 +0200
Message-ID: <20150428132838.GA10782@kroah.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1428515119-25248-2-git-send-email-peter@hurleysoftware.com>
 <CAL_JsqLvKVDTD9-ees=gynVD2WDtEPGAa+XPCCpkX9ydaAVyTw@mail.gmail.com>
 <553F862A.2000709@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <553F862A.2000709@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robherring2@gmail.com>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 28, 2015 at 09:07:54AM -0400, Peter Hurley wrote:
> On 04/08/2015 05:24 PM, Rob Herring wrote:
> > On Wed, Apr 8, 2015 at 12:45 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> >> stdout-path defines ':' as a path terminator and commit 75c28c09af99a
> >> ("of: add optional options parameter to of_find_node_by_path()") added
> >> the necessary support to parse paths terminated with ':'.
> >> commit 7914a7c5651a5 ("of: support passing console options with
> >> stdout-path") added options string support to the stdout-path property,
> >> which broke earlycon.
> >>
> >> Add the same support to earlycon to process 'stdout-path' properties
> >> which contain an options string.
> >>
> >> Requires: "libfdt: Add fdt_path_offset_namelen()"
> > 
> > Since David has applied this, we can cherrypick that commit for the
> > kernel copy. Ideally, we would do a dtc sync, but it's not going to
> > happen for 4.1.
> 
> Rob,
> 
> Greg pulled this series for -next and kbuild robot promptly blew up
> because of this missing commit. Are you planning on cherry-picking
> "libfdt: Add fdt_path_offset_namelen()"?

Can I just take that patch so I don't see the build issues in my branch?

thanks,

greg k-h
