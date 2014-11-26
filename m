From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty, serial, 8250: remove __init from function serial8250_console_setup()
Date: Wed, 26 Nov 2014 09:25:56 -0500
Message-ID: <5475E2F4.7090603@hurleysoftware.com>
References: <20141125175121.GA32573@kroah.com> <1416954082-1755-1-git-send-email-avanzini.arianna@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416954082-1755-1-git-send-email-avanzini.arianna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arianna Avanzini <avanzini.arianna@gmail.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/25/2014 05:21 PM, Arianna Avanzini wrote:
> Some RS232 adapters handled by this driver are hotpluggable. The function
> serial8250_console_setup() is called during device init and is defined with
> the __init macro. In case the driver is built-in, hotplugging the device after
> the initialization phase has been completed (and the related memory has been
> freed) results in a kernel crash.
> This commit fixes the issue by removing __init from the function definition.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
