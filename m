From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V1 1/1] serial: 8250_fintek: Fix finding base_port with
 activated SuperIO
Date: Wed, 18 Oct 2017 21:04:35 +0100
Message-ID: <20171018210435.576fe152@alans-desktop>
References: <1508221388-25001-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1508221388-25001-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: stable-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, rel+kernel@agilox.net, stable@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, hpeter+linux_kernel@gmail.com, peter_hong@fintek.com.tw
List-Id: linux-serial@vger.kernel.org

On Tue, 17 Oct 2017 14:23:08 +0800
"Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com> wrote:

> The SuperIO will be configured at boot time by BIOS, but some BIOS
> will not deactivate the SuperIO when the end of configuration. It'll
> lead to mismatch for pdata->base_port in probe_setup_port(). So we'll
> deactivate all SuperIO before activate special base_port in
> fintek_8250_enter_key().
> 
> Tested on iBASE MI802.

Good point.

Reviewd-by: Alan Cox <alan@linux.intel.com>

Alan
