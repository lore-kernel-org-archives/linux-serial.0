From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHv3 3/9] serial: vt8500: Add devicetree support for
 vt8500-serial
Date: Tue, 21 Aug 2012 23:12:55 +0100
Message-ID: <20120821231255.71a7515a@pyramind.ukuu.org.uk>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <1345582058-2291-4-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1345582058-2291-4-git-send-email-linux@prisktech.co.nz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-fbdev@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, vt8500-wm8505-linux-kernel@googlegroup.com, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, linux-serial@vger.kernel.org, rtc-linux@googlegroups.com, Stephen Warren <swarren@nvidia.com>, Mike Turquette <mturquette@ti.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 22 Aug 2012 08:47:32 +1200
Tony Prisk <linux@prisktech.co.nz> wrote:

> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/tty/serial/vt8500_serial.c |   37 ++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)

Can we have a comment attached to a change this size. In particular one
describing why it gone from 4 to 6 ports, and why the port id twiddling.

Is there a reason you can't use the device tree port id ?

What are the regression risks for existing users expecting the pdev->id
binding ?
