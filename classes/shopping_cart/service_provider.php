<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Shopping_cart subsystem callback implementation for local_shopping_cart.
 *
 * @package    local_shopping_cart
 * @category   booking
 * @copyright  2022 Georg Maißer <info@wunderbyte.at>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

namespace local_shopping_cart\shopping_cart;

use context_module;
use local_shopping_cart\local\entities\cartitem;
use local_shopping_cart\price;

/**
 * Shopping_cart subsystem callback implementation for local_shopping_cart.
 * This is just useful for testing to generate dummy data.
 *
 * @copyright  22022 Georg Maißer <info@wunderbyte.at>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class service_provider implements \local_shopping_cart\local\callback\service_provider {

    /**
     * Callback function that returns the costs and the accountid
     * for the course, just for testing.
     *
     * @param int $optionid
     * @return \shopping_cart\cartitem
     */
    public static function get_cartitem(int $optionid): cartitem {
        global $DB;

        return new cartitem(1,
                            'my test item',
                            10,
                            'EUR',
                            'local_shopping_cart',
                            'item description');
    }

    /**
     * Callback function that handles inscripiton after fee was paid.
     * @param integer $itemid
     * @param integer $paymentid
     * @param integer $userid
     * @return boolean
     */
    public static function successful_checkout(int $itemid, int $paymentid, int $userid):bool {
        global $DB;

        // TODO: Set booking_answer to 1.

        return true;
    }
}
