From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH] serial: imx: Correct comment imx_flush_buffer()
Date: Wed, 04 Oct 2017 17:12:39 +0100
Message-ID: <1507133559.26507.16.camel@collabora.co.uk>
References: <1506676939-20940-1-git-send-email-martyn.welch@collabora.co.uk>
         <20171003182755.GA32455@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003182755.GA32455@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-10-03 at 20:27 +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 29, 2017 at 10:22:19AM +0100, Martyn Welch wrote:
> > The comment in imx_flush_buffer() states that the state of 4 registers
> > are to be saved/restored, then only saves and restores 3 registers. The
> > missing register (UBRC) is read only and thus can't be restored.
> > 
> > Update the comment to reflect reality.
> 
> Always run checkpatch.pl so you don't get grumpy maintainers telling you
> to run checkpatch.pl :(

Sorry Greg, must have got out of sync on that one :-(

Martyn
