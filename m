From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Tue, 10 Sep 2019 08:57:37 +0200
Message-ID: <mvm4l1kskny.fsf@suse.de>
References: <20190910055923.28384-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190910055923.28384-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 10 Sep 2019 07:59:23 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, paul.walmsley@sifive.com, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:

> The sifive serial driver implements earlycon support,

It should probably be documented in admin-guide/kernel-parameters.txt.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
