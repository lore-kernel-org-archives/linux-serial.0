From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 3/4] new serial flow control
Date: Mon, 10 Oct 2005 00:04:20 +0100
Message-ID: <1128899060.2938.7.camel@localhost.localdomain>
References: <200501052341.j05Nfod27823@mail.osdl.org>
	 <20050105235301.B26633@flint.arm.linux.org.uk>
	 <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
	 <20051009000153.GA23083@flint.arm.linux.org.uk>
	 <20051009002129.GJ5150@bouh.residence.ens-lyon.fr>
	 <20051009083724.GA14335@flint.arm.linux.org.uk>
	 <20051009100909.GF5150@bouh.residence.ens-lyon.fr>
	 <20051009111718.GA13144@flint.arm.linux.org.uk>
	 <20051009113313.GD5104@bouh.residence.ens-lyon.fr>
	 <20051009114406.GE5104@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932302AbVJIWg4@vger.kernel.org>
In-Reply-To: <20051009114406.GE5104@bouh.residence.ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sul, 2005-10-09 at 13:44 +0200, Samuel Thibault wrote:
> > Yes, of course. But can't this be disabled too?
> 
> (I mean, the FIFOs)

In the USB case generally not. Also many high end devices are polled
with big buffers and have no IRQ support. It works for the 16x50s that
are most PCs today however and that is enough IMHO to be relevant for
now (next gen PC's probably won't have serial of course)
