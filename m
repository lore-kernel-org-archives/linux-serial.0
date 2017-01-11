From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] TI DA8xx/OMAPL13x/AM17xx/AM18xx/66AK2x UART
Date: Wed, 11 Jan 2017 09:06:30 +0100
Message-ID: <20170111080630.GA28580@kroah.com>
References: <1483642460-6891-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1483642460-6891-1-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Lechner <david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Bailon <abailon@baylibre.com>, linux-serial@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Franklin S Cooper Jr <fcooper@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 05, 2017 at 12:54:16PM -0600, David Lechner wrote:
> This series adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/66AK2x
> UART. These SoCs have a non-standard register for UART power management that
> needs special handling in the UART driver.
> 
> Greg, the first two patches will need to go through your tree. Sekhar and
> Santosh will pick up the 3 and 4 patches respectively.

Ok, I've now taken those two.

thanks,

greg k-h
