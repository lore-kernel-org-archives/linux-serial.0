From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH] serial:8250:8250_pci: delete unneeded quirk entries
Date: Fri, 06 Mar 2015 21:21:20 +0000
Message-ID: <54FA1A50.1000404@nexus-software.ie>
References: <20150306170835.GA1990@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150306170835.GA1990@udknight>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang YanQing <udknight@gmail.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/03/15 17:08, Wang YanQing wrote:
> These quirk entries have the same effect as default
> quirk entry, so we can just delete them.
>
> Signed-off-by: Wang YanQing <udknight@gmail.com>

ACK - does exactly what it says on the tin.

Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
