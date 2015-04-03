From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove
 setup_early_serial8250_console()
Date: Fri, 3 Apr 2015 21:00:44 +0200
Message-ID: <20150403190044.GA24702@kroah.com>
References: <CAE9FiQVBxGt_jX-juzf4vvc_6MgiiSixW6RtVTz1aUTw0h3Rmg@mail.gmail.com>
 <CAE9FiQVaM650O139RgLcHRv7NGUVVMqSETq0YJ+7OAWVg=0Y0A@mail.gmail.com>
 <CAE9FiQUJq0zi2gx0jM1AQp60FhyaytKEMV_mpY+fNc3OATnCBA@mail.gmail.com>
 <CAE9FiQV0rfOfo3-=yQOYLDD-x+48_OuWfkHVNy-+oTzWvgr9Ew@mail.gmail.com>
 <CAE9FiQX2gQQcD5OrFkDCN5Ew746H1kd5+VgpAcSNvEqg-gFx7Q@mail.gmail.com>
 <551E6D61.7000501@hurleysoftware.com>
 <CAE9FiQXaOZOf4hj72iUpDoYgGTuO+jwF34qOeiLw=3rrWK+ucA@mail.gmail.com>
 <551ED011.1030004@hurleysoftware.com>
 <CAE9FiQW4PM1aozMOXMfvey2=zVjm3uMVLGW3924eidACBbTjag@mail.gmail.com>
 <551EDB92.9070008@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <551EDB92.9070008@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 03, 2015 at 02:27:30PM -0400, Peter Hurley wrote:
> I have no problem fixing this _if this is causing actual regressions_,
> and not simply some minor inconvenience that can be fixed by editing your
> grub command line.

But, you can't break working command lines from previous kernel
releases.  Undocumented or not, sorry.  It's a working configuration.
Upgrading a kernel can not break that.

sorry,

greg k-h
