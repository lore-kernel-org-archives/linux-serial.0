From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/12] serial: sh-sci: use dmaengine_terminate_all() API
Date: Sat, 11 Oct 2014 13:21:32 -0700
Message-ID: <20141011202132.GB29591@kroah.com>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
 <1413042040-28222-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413042040-28222-9-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Oct 11, 2014 at 09:10:37PM +0530, Vinod Koul wrote:
> The drivers should use dmaengine_terminate_all() API instead of
> accessing the device_control which will be deprecated soon
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
