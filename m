From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: imx: Correct comment imx_flush_buffer()
Date: Tue, 3 Oct 2017 20:27:55 +0200
Message-ID: <20171003182755.GA32455@kroah.com>
References: <1506676939-20940-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506676939-20940-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 29, 2017 at 10:22:19AM +0100, Martyn Welch wrote:
> The comment in imx_flush_buffer() states that the state of 4 registers
> are to be saved/restored, then only saves and restores 3 registers. The
> missing register (UBRC) is read only and thus can't be restored.
> 
> Update the comment to reflect reality.

Always run checkpatch.pl so you don't get grumpy maintainers telling you
to run checkpatch.pl :(
