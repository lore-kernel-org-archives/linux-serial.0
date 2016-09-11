From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/9] tty: move hw_stopped flag to tty_port
Date: Sun, 11 Sep 2016 22:15:37 +0100
Message-ID: <20160911221537.34c14cdc@lxorguk.ukuu.org.uk>
References: <20160909223711.26238-1-robh@kernel.org>
        <20160909223711.26238-4-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-4-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri,  9 Sep 2016 17:37:04 -0500
Rob Herring <robh@kernel.org> wrote:

> hw_stopped is a property of the tty port rather than the tty, so move it
> to tty_port struct and remove another dependency on tty_struct from
> drivers.
> 
> Converted with coccinelle:

This one makes sense. It's moving the object to the right place


Acked-by: Alan Cox <alan@linux.intel.com>
