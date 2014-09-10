From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v5 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Wed, 10 Sep 2014 09:09:28 +0200
Message-ID: <20140910070928.GF3578@distanz.ch>
References: <1410276703-5274-1-git-send-email-matthias.bgg@gmail.com>
 <1410276703-5274-2-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410276703-5274-2-git-send-email-matthias.bgg@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, alan@linux.intel.com, varkabhadram@gmail.com, heiko@sntech.de, yingjoe.chen@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2014-09-09 at 17:31:42 +0200, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> The device has a highspeed register which influences the calcualtion
> of the divisor. The chip lacks support for some baudrates. When requested,
> we set the divisor to the next smaller baudrate and adjust the c_cflag
> accordingly.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

All my previous review comments have been addressed.

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
