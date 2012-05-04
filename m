From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Fri, 4 May 2012 17:33:56 +0100
Message-ID: <20120504173356.000fb9da@pyramind.ukuu.org.uk>
References: <1335817637-2862-1-git-send-email-preston.fick@silabs.com>
	<1436626.86ImxHLlqB@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436626.86ImxHLlqB@ws-stein>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Stein <a.stein@systec-electronic.com>
Cc: Preston Fick <pffick@gmail.com>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, preston.fick@silabs.com
List-Id: linux-serial@vger.kernel.org

On Fri, 04 May 2012 18:26:58 +0200
Alexander Stein <a.stein@systec-electronic.com> wrote:

> Am Montag, 30. April 2012, 15:27:17 schrieb Preston Fick:
> > This fix contains several changes that allow toggling of GPIO on CP210x
> > devices that support it. Changes include:
> > * Added in part number support, necessary to see if the connected device
> > supports the GPIO functionality
> > * Added two IOCTLs and ioctl function to allow GET/SET of GPIO
> > * Added in new #defines for partnum support, new USB requests
> > * Changed "Config request types" section to contain more correct definitions
> > for request recipient
> > 
> > Signed-off-by: Preston Fick <preston.fick@silabs.com>
> 
> Do you actually need to create new ioctls? You also could support gpiolib and 
> create a gpiochip for that.

See my follow up posting, and comment on that proposal.
