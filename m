From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 07/10] drivers: PL011: move cts_event workaround into
 separate function
Date: Sat, 7 Mar 2015 04:00:17 +0100
Message-ID: <20150307030017.GA29063@kroah.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-8-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1425491994-23913-8-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: rob.herring@linaro.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-serial@vger.kernel.org, jslaby@suse.cz, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 05:59:51PM +0000, Andre Przywara wrote:
> To avoid lines with more than 80 characters and to make the
> pl011_int() function more readable, move the workaround out into a
> separate function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Conflicts:
> 
> 	drivers/tty/serial/amba-pl011.c

Why is this here in the changelog?  It doesn't make sense when sending
patches out :)

Please fix up and resend the patches I didn't apply.

thanks,

greg k-h
