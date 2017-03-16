From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 0/7] staging: speakup: introduce tty-based comms
Date: Thu, 16 Mar 2017 10:26:07 +0100
Message-ID: <20170316092607.mxailtjawpusj5g2@var.youpi.perso.aquilenet.fr>
References: <20170313220551.312820470@gmail.com>
 <20170313221404.GA22871@kroah.com>
 <20170314004701.kuecu2zu4md5ccrq@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20170314004701.kuecu2zu4md5ccrq@var.youpi.perso.aquilenet.fr>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, okash.khawaja@gmail.com, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Kirk Reiser <kirk@reisers.ca>, Chris Brannon <chris@the-brannons.com>, speakup@linux-speakup.org
List-Id: linux-serial@vger.kernel.org

Hello,

Also, could serdev also provide an send_xchar function similar to the
send_xchar tty driver function?  We need this to send high-priority
characters.

Samuel
