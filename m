From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] serial: sirf: make uart register info static
Date: Sat, 25 Jun 2016 14:01:50 -0700
Message-ID: <20160625210150.GA3305@kroah.com>
References: <1465322772-26125-1-git-send-email-ben.dooks@codethink.co.uk>
 <1465322772-26125-2-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1465322772-26125-2-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Barry Song <baohua@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 07, 2016 at 07:06:12PM +0100, Ben Dooks wrote:
> The driver does not export the two structures that
> define the uart register mappings outside of the
> driver, so make them static to avoid the following
> warnings:
> 
> drivers/tty/serial/sirfsoc_uart.h:124:30: warning: symbol 'sirfsoc_usp' was not declared. Should it be static?
> drivers/tty/serial/sirfsoc_uart.h:190:30: warning: symbol 'sirfsoc_uart' was not declared. Should it be static?
> 
> Note, we don't move these into the driver .c file as this would
> be a larger change. However they really should not belong in the
> header file like this.

Please do the correct thing here and move them into the .c file.

thanks,

greg k-h
