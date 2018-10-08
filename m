From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH stable v2 0/2] termios: Alpha BOTHER/IBSHIFT,
 tty_baudrate fix
Date: Mon, 8 Oct 2018 17:34:58 +0200
Message-ID: <20181008153458.GY3774@localhost>
References: <20181008040620.1248277-1-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008040620.1248277-1-hpa@zytor.com>
Sender: stable-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Tobias Klausmann <klausman@schwarzvogel.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 07, 2018 at 09:06:18PM -0700, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> It turns out that Alpha is the only architecture that never
> implemented BOTHER and IBSHIFT, which is otherwise ages old. This is
> one thing that has held up glibc support for this feature (all other
> architectures have supported these for about a decade, at least before
> the current 3.2 glibc cutoff.)
> 
> Furthermore, in the process of dealing with this, I discovered that
> the current code in tty_baudrate.c can read past the end of the
> baud_table[] on Alpha and PowerPC. The second patch in this series
> fixes that, but it also cleans up the code substantially by
> auto-generating the table and, since all architectures now have them,
> removing all conditionals for BOTHER and IBSHIFT existing.
> 
> Tagging for stable because these are concrete and immediate
> problems.

This isn't stable material in its current form. If you want to plug the
alpha and powerpc info leaks in the stable trees, then you need a
minimal fix for that, which you can then your clean ups and new features
on.

Johan
