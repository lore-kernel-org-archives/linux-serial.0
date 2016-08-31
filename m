From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 3/3] serial: 8250_dw: Add quirk for APM X-Gene SoC
Date: Wed, 31 Aug 2016 16:16:02 +0200
Message-ID: <20160831141602.GA4725@kroah.com>
References: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1471941208-27963-4-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471941208-27963-4-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Feng Kan <fkan@apm.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 23, 2016 at 11:33:28AM +0300, Heikki Krogerus wrote:
> The APM X-Gene SoC UART is the only board that still needs
> the hard-coded values, so handle it separately in
> dw8250_quirks(). The other ACPI platforms are able to
> provide the values with device properties.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Feng Kan <fkan@apm.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
