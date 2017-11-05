From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] tty: serial: meson: allow baud-rates lower than 9600
Date: Sun, 5 Nov 2017 08:21:41 +0100
Message-ID: <20171105072141.GC28366@kroah.com>
References: <19343ad6-75de-4059-825a-98ed40ecf423@myway.de>
 <20171104131352.GA9271@kroah.com>
 <bef0434b-fa23-464e-8c6c-d1f7dc678767@myway.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <bef0434b-fa23-464e-8c6c-d1f7dc678767@myway.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: V10lator <v10lator@myway.de>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sun, Nov 05, 2017 at 05:26:59AM +0100, V10lator wrote:
> Am Samstag, 4. November 2017 14:13:52 CET schrieb Greg Kroah-Hartman:
> > What changed from v2?
> 
> Nothing. I just re-based the patch on a fresh git clone as you couldn't
> merge v2.

Then you need to say so somewhere otherwise I, and everyone else, has no
idea what changed.

Remember, I get thousands of patches a week to review, and have the
short-term memory of a squirrel :(

thanks,

greg k-h
