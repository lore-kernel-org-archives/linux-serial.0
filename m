From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v1 05/12] serial: 8250_dma: switch to new
 dmaengine_terminate_* API
Date: Thu, 7 Apr 2016 16:55:08 -0700
Message-ID: <5706F35C.3030805@hurleysoftware.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1460061433-63750-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-6-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/07/2016 01:37 PM, Andy Shevchenko wrote:
> Convert dmaengine_terminate_all() calls to synchronous and asynchronous
> versions where appropriate.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
