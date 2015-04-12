From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] drivers/tty/serial/8250/8250_core.c: remove CONFIG_HUB6
Date: Sun, 12 Apr 2015 12:05:43 -0400
Message-ID: <552A97D7.4070701@hurleysoftware.com>
References: <1428851002-4815-1-git-send-email-valentinrothberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428851002-4815-1-git-send-email-valentinrothberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Valentin Rothberg <valentinrothberg@gmail.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/12/2015 11:03 AM, Valentin Rothberg wrote:
> This file local CPP identifier is not referenced anywhere else, so we
> can safely remove it.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
