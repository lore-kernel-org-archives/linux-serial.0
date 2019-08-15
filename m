From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 11/13] serial: lpc32xx: allow compile testing
Date: Thu, 15 Aug 2019 15:40:49 +0200
Message-ID: <20190815134049.GA3372@kroah.com>
References: <20190809144043.476786-1-arnd@arndb.de>
 <20190809144043.476786-12-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809144043.476786-12-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 09, 2019 at 04:40:37PM +0200, Arnd Bergmann wrote:
> The lpc32xx_loopback_set() function in hte lpc32xx_hs driver is the
> one thing that relies on platform header files. Move that into the
> core platform code so we only need a variable declaration for it,
> and enable COMPILE_TEST building.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
