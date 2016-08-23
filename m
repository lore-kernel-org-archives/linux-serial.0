From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] ACPI / LPSS: Provide build-in properties of the UART
Date: Tue, 23 Aug 2016 10:03:22 +0300
Message-ID: <20160823070322.GB30827@lahna.fi.intel.com>
References: <1471875855-110782-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1471875855-110782-3-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471875855-110782-3-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 22, 2016 at 05:24:14PM +0300, Heikki Krogerus wrote:
> The UART driver, dw8250.c, needs some details regarding the
> Designware UART. For ACPI enumerated devices the values are
> hard-coded, but since the driver also reads the values from
> device properties, providing them with build-in properties.
> This allows us to later remove the hard-coded values from
> the driver.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Good idea.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
